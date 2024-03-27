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

    init(area: CGRect, name: String = "New Level", boardObjects: BoardObjectSet = BoardObjectSet()) {
        self.name = name
        self.area = area
        self.boardObjects = boardObjects
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
}
