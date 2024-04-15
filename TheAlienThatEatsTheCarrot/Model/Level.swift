//
//  Level.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

struct Level {
    var name: String
    var area: CGRect
    var boardObjects: BoardObjectSet
    var bestScore: Int
    var bestTime: Int
    var bestCarrot: Int

    init(area: CGRect, name: String = "New Level", boardObjects: BoardObjectSet = BoardObjectSet(), bestScore: Int = 0, bestTime: Int = 0, bestCarrot: Int = 0) {
        self.name = name
        self.area = area
        self.boardObjects = boardObjects
        self.bestScore = bestScore
        self.bestTime = bestTime
        self.bestCarrot = bestCarrot
    }

    mutating func scale(toFit newArea: CGRect) {
        self.boardObjects.scale(from: area, to: newArea)
        self.area = newArea
    }

    mutating func add(boardObject: any BoardObject) {
        self.boardObjects.add(boardObject: boardObject)
    }

    func canAdd(boardObject: any BoardObject) -> Bool {
        self.boardObjects.canAdd(boardObject: boardObject)
    }

    mutating func remove(boardObject: any BoardObject) {
        self.boardObjects.remove(boardObject: boardObject)
    }

    func findBoardObject(at point: CGPoint) -> (any BoardObject)? {
        boardObjects.findBoardObject(at: point)
    }

    func nearestNonOverlappingPosition(for object: BoardObject) -> CGPoint {
        boardObjects.nearestNonOverlappingPosition(for: object)
    }

    mutating func reset() {
        boardObjects.removeAll()
    }
}
