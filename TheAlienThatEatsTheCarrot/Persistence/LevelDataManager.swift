//
//  LevelDataManager.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 24/3/24.
//

import CoreData

struct LevelDataManager {
    let context: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataManager.sharedManager.context) {
        self.context = mainContext
    }

    /// Fetches the saved `LevelData` matching the provided `levelName`. Throws errors
    /// when the level name does not exist or duplicate level names are detected.
    ///   - Parameters:
    ///     - levelName: the name of the level to fetch.
    ///   - Returns : the fetched `LevelData`.
    func fetchLevelData(levelName: String) throws -> LevelData {
        let levelDatas = try fetchAllLevelDataMatching(levelName: levelName)
        guard !levelDatas.isEmpty else {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        }
        guard levelDatas.count == 1 else {
            throw TheAlienThatEatsTheCarrotError.duplicateLevelNameError(levelName: levelName)
        }
        return levelDatas[0]
    }

    /// Saves the given `Level`, with the option to overwrite any existing `LevelData` with the same name.
    /// Throws an error if an existing `LevelData` has the same name as the `Level` provided and
    /// overwrite is set to `false`.
    ///   - Parameters:
    ///     - level: the `Level` to be saved.
    ///     - overwrite: whether or not to overwrite any existing `LevelData` with the same name.
    func saveLevelData(level: Level, overwrite: Bool = false) throws {
        guard let matchingLevelData = try? fetchAllLevelDataMatching(levelName: level.name) else {
            return
        }
        let containsDuplicate = !matchingLevelData.isEmpty
        if containsDuplicate && !overwrite {
            throw TheAlienThatEatsTheCarrotError.duplicateLevelNameError(levelName: level.name)
        } else if containsDuplicate {
            for duplicate in matchingLevelData {
                context.delete(duplicate)
            }
        }
        _ = level.toData(context: context)
        try context.save()
    }

    func fetchAllLevelData() throws -> [LevelData] {
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
}
