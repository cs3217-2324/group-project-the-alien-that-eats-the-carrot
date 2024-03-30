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
//    private lazy var selectedTool: Tool = NormalPegTool(toolDelegate: self)
//    var storageManager = StorageManager.sharedManager // for persistent storage
//

    init(area: CGRect, view: LevelDesignerViewController) {
        self.level = Level(area: area)
        self.view = view
    }

//    func changeTool(to selectedTool: ToolType) {
//        self.selectedTool = DefaultTool.factory(typeToCreate: selectedTool, delegate: self)
//    }
//
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

//    func handlePinchStart(at location: CGPoint) {
//        guard let boardObject = level.findBoardObject(at: location) else {
//            return
//        }
//        panObject = boardObject
//    }
//
//    func handlePinchChange(scale: CGFloat) {
//        // if can scale, display new object
//        guard let newGameObject = selectedTool.handlePinchChange(scale: scale) else {
//            return
//        }
//        view.resizePinchImage(newGameObject: newGameObject)
//    }
//
//    func handlePinchEnd() {
//        selectedTool.handlePinchEnd()
//    }
//
    private var panObject: (any BoardObject)?

    func handlePanStart(at location: CGPoint) {
        guard let boardObject = level.findBoardObject(at: location) else {
            return
        }
        print("handle pan start - object found")
        panObject = boardObject
    }

    func handlePanChange(at location: CGPoint) {
        guard let boardObject = panObject else {
            return
        }
        print("handle pan change - object found")
        move(boardObject: boardObject, to: location)
    }

    func handlePanEnd() {
        print("handle pan end")
        panObject = nil
    }
//
//    func handleSwipeLeft(at touchPoint: CGPoint) {
//        guard let peg = findGameObject(at: touchPoint) as? Peg else {
//            // no peg obj found
//            return
//        }
//        selectedTool.handleSwipeLeft(peg: peg)
//    }
//
//    func handleSwipeRight(at touchPoint: CGPoint) {
//        guard let peg = findGameObject(at: touchPoint) as? Peg else {
//            // no peg obj found
//            return
//        }
//        selectedTool.handleSwipeRight(peg: peg)
//    }
//
//    func reset() {
//        level.reset()
//        view.reset()
//    }
//
//    func save(levelName: String) throws {
//        level.name = levelName
//        try storageManager.saveLevel(level: level)
//    }
//
//    func loadLevel(levelName: String) throws {
//        reset()
//        guard let levelData = try storageManager.fetchLevel(levelName: levelName) else {
//            return
//        }
//        // level fetched successfully
//        // set up Model and View
//        self.level = try Level(data: levelData)
//        view.loadLevel(with: level.gameObjects)
//    }
//
//    func loadLevel(level: Level) {
//        reset()
//        // set up Model and View
//        self.level = level
//        view.loadLevel(with: level.gameObjects)
//    }
//

//
    // MARK: - Delegating to view and model
    func add(boardObject: BoardObject, addToView: Bool = true) {
        print("adding object - check canAdd()")
        if !level.canAdd(boardObject: boardObject) {
            return
        }
        print("adding object to level")
        level.add(boardObject: boardObject)
        if addToView {
            print("adding object to view")
            let id = ObjectIdentifier(boardObject)
            view.addImage(id: id, objectType: boardObject.type, center: boardObject.position, width: boardObject.width, height: boardObject.height)
        }
    }

    func remove(boardObject: BoardObject) {
        level.remove(boardObject: boardObject)
        view.removeImage(id: ObjectIdentifier(boardObject))
    }

    func move(boardObject: BoardObject, to location: CGPoint) {
        print("object moving")
        remove(boardObject: boardObject)

        var newBoardObject = ObjectType.createObject(from: boardObject.type, position: location)
        print("new object created")
        if !level.canAdd(boardObject: newBoardObject) {
            newBoardObject = boardObject
        }
        add(boardObject: newBoardObject)
        panObject = newBoardObject
    }
//
//    func add(block: Block, addToView: Bool = true) {
//        if !level.canAdd(gameObject: block) {
//            return
//        }
//        level.add(gameObject: block)
//        if addToView {
//            view.addBlockImage(at: block.center, width: block.width, height: block.height, angle: block.angle)
//        }
//    }
//
//    func remove(block: Block) {
//        level.remove(gameObject: block)
//        view.removeBlockImage(at: block.center)
//    }
//
//    func move(originalObject: any GameObject, newObject: any GameObject) {
//        level.remove(gameObject: originalObject)
//        level.add(gameObject: newObject)
//    }
//
//    func findGameObject(at point: CGPoint) -> (any GameObject)? {
//        level.findGameObject(at: point)
//    }
//
//    func canAdd(gameObject: any GameObject) -> Bool {
//        level.canAdd(gameObject: gameObject)
//    }
//
//    func returnPanImage(center: CGPoint) {
//        view.returnPanImage(center: center)
//    }
}
