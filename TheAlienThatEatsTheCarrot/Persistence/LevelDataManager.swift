//
//  LevelDataManager.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 24/3/24.
//

import CoreData

struct LevelDataManager {

    static let sharedManager = LevelDataManager()
    let context = CoreDataManager.sharedManager.context
    private var preloadedLevels: [Level] = []

    private init() {
        deleteAllData() // use when want to clear all data on ipad simulator
        fetchPreloadedLevels()
    }

    /// Fetches the saved `LevelData` matching the provided `levelName`. Throws errors
    /// when the level name does not exist or duplicate level names are detected.
    ///   - Parameters:
    ///     - levelName: the name of the level to fetch.
    ///   - Returns : the fetched `LevelData`.
    private func fetchLevelData(levelName: String) throws -> LevelData {
        let levelDatas = try fetchAllLevelDataMatching(levelName: levelName)
        if levelDatas.isEmpty {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        } else if levelDatas.count > 1 {
            throw TheAlienThatEatsTheCarrotError.duplicateLevelNameError(levelName: levelName)
        }
        return levelDatas[0]
    }

    func fetchLevel(levelName: String) throws -> Level {
        let levelData = try fetchLevelData(levelName: levelName)
        return try Level(data: levelData)
    }

    /// Saves the given `Level`, with the option to overwrite any existing `LevelData` with the same name.
    /// Throws an error if an existing `LevelData` has the same name as the `Level` provided and
    /// overwrite is set to `false`.
    ///   - Parameters:
    ///     - level: the `Level` to be saved.
    ///     - overwrite: whether or not to overwrite any existing `LevelData` with the same name.
    func saveLevelData(level: Level, overwrite: Bool = false) throws {
        let matchingLevelData = try fetchAllLevelDataMatching(levelName: level.name)
        if !matchingLevelData.isEmpty {
            if !overwrite {
                throw TheAlienThatEatsTheCarrotError.duplicateLevelNameError(levelName: level.name)
            } else {
                for duplicate in matchingLevelData {
                    context.delete(duplicate)
                }
            }
        }
        _ = level.toData(context: context)
        try context.save()
        print("saved level \(level.name)")
    }

    private func fetchAllLevelData() throws -> [LevelData] {
        let request = LevelData.fetchRequest()
        return try context.fetch(request)
    }

    private func fetchAllLevelDataMatching(levelName: String) throws -> [LevelData] {
        let fetchRequest = createLevelDataFetchRequest(withFilter: "name == '\(levelName)'")
        return try context.fetch(fetchRequest)
    }

    private func createLevelDataFetchRequest(withFilter filter: String) -> NSFetchRequest<LevelData> {
        let request = LevelData.fetchRequest() as NSFetchRequest<LevelData>
        let pred = NSPredicate(format: filter)
        request.predicate = pred
        return request
    }

    func fetchLevelNames() -> [String] {
        do {
            let levelDatas = try fetchAllLevelData()
            if levelDatas.isEmpty {
                return []
            }
            let levelNames = levelDatas.compactMap({ $0.name })
            return levelNames
        } catch {
            print("Error fetching level data: \(error)")
            return []
        }
    }

    func fetchLevels() -> [Level] {
        var levels: [Level] = []
        do {
            let levelDatas = try fetchAllLevelData()
            if levelDatas.isEmpty {
                return levels
            }
            for levelData in levelDatas {
                let level = try Level(data: levelData)
                levels.append(level)
                print("fetched level \(level.name)")
            }
        } catch {
            print("Error fetching level data: \(error)")
            return levels
        }
        return levels
    }

    func fetchEmptyLevel() -> Level? {
        guard let fileURL = Bundle.main.url(forResource: "emptyLevel", withExtension: "json") else {
            print("Error: emptyLevel.json file not found")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] ?? []
            for jsonDict in jsonArray {
                let jsonString = String(data: try JSONSerialization.data(withJSONObject: jsonDict, options: []), encoding: .utf8)
                if let level = jsonString.flatMap({ Level.fromJSONString(jsonString: $0) }) {
                    return level
                } else {
                    print("Error: Failed to create Level instance from JSON string")
                }
            }
        } catch {
            print("Error decoding defaultLevels.json: \(error)")
        }
        return nil
    }

    mutating func fetchPreloadedLevels() {
        guard let fileURL = Bundle.main.url(forResource: "defaultLevels", withExtension: "json") else {
            print("Error: emptyLevel.json file not found")
            return
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] ?? []
            for jsonDict in jsonArray {
                let jsonString = String(data: try JSONSerialization.data(withJSONObject: jsonDict, options: []), encoding: .utf8)
                if let level = jsonString.flatMap({ Level.fromJSONString(jsonString: $0) }) {
                    if preloadedLevels.contains(where: { $0.name == level.name }) {
                        // "Level with name '\(levelName)' already exists. Skipping preloaded level."
                        continue
                    }
                    preloadedLevels.append(level)
                    print("fetched preloaded level \(level.name)")
                    try saveLevelData(level: level, overwrite: true)
                } else {
                    print("Error: Failed to create Level instance from JSON string")
                }
            }
        } catch {
            print("Error decoding defaultLevels.json: \(error)")
        }
        return
    }

    private mutating func deleteAllData() {
        print("deleting all data")
        do {
            let levelDatas = try fetchAllLevelData()
            for levelData in levelDatas {
                context.delete(levelData)
            }
        } catch {
            print("Error fetching level data: \(error)")
            return
        }
    }
}
