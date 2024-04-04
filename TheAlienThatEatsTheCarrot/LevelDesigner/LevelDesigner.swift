//
//  LevelDesigner.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 27/3/24.
//

import Foundation

class LevelDesigner {
    var level: Level
    var view: LevelDesignerViewController
    var storageManager = LevelDataManager()

    init(area: CGRect, view: LevelDesignerViewController) {
        self.level = Level(area: area)
        self.view = view
    }

    func handleTap(at location: CGPoint, objectType: ObjectType) {
        let boardObject = ObjectType.createObject(from: objectType, position: location)
        add(boardObject: boardObject)
    }

    func handleLongPress(at location: CGPoint) {
        guard let boardObject = level.findBoardObject(at: location) else {
            return
        }
        remove(boardObject: boardObject)
    }

    private var panObject: (any BoardObject)?

    func handlePanStart(at location: CGPoint) {
        guard let boardObject = level.findBoardObject(at: location) else {
            return
        }
        panObject = boardObject
    }

    func handlePanChange(at location: CGPoint) {
        guard let boardObject = panObject else {
            return
        }
        move(boardObject: boardObject, to: location)
    }

    func handlePanEnd() {
        panObject = nil
    }

    func reset() {
        level.reset()
        view.reset()
    }

    func saveLevel(levelName: String, overwrite: Bool) throws {
        level.name = levelName
        try storageManager.saveLevelData(level: level, overwrite: overwrite)
    }

    func loadLevel(levelName: String) throws {
        reset()
        do {
            self.level = try storageManager.fetchLevel(levelName: levelName)
            loadView(with: level.boardObjects)
        } catch {
            throw error
        }
    }

    func loadLevel(level: Level) {
        reset()
        self.level = level
        loadView(with: level.boardObjects)
    }

    func fetchLevelNames() -> [String] {
        storageManager.fetchLevelNames()
    }

    // MARK: - Delegating to view and model
    func add(boardObject: BoardObject, addToView: Bool = true) {
        if !level.canAdd(boardObject: boardObject) {
            return
        }
        level.add(boardObject: boardObject)
        if addToView {
            let id = ObjectIdentifier(boardObject)
            view.addImage(id: id, objectType: boardObject.type, center: boardObject.position, width: boardObject.width, height: boardObject.height)
        }
    }

    func remove(boardObject: BoardObject) {
        level.remove(boardObject: boardObject)
        view.removeImage(id: ObjectIdentifier(boardObject))
    }

    func move(boardObject: BoardObject, to location: CGPoint) {
        remove(boardObject: boardObject)

        var newBoardObject = ObjectType.createObject(from: boardObject.type, position: location)
        if !level.canAdd(boardObject: newBoardObject) {
            newBoardObject = boardObject
        }
        add(boardObject: newBoardObject)
        panObject = newBoardObject
    }

    private func loadView(with boardObjects: BoardObjectSet) {
        for boardObject in boardObjects.allObjects {
            let id = ObjectIdentifier(boardObject)
            view.addImage(id: id, objectType: boardObject.type, center: boardObject.position, width: boardObject.width, height: boardObject.height)
        }
    }
}
