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

    init(name: String,
         area: CGRect) {
        self.name = name
        self.area = area
        self.boardObjects = BoardObjectSet()
    }

    mutating func scale(toFit newArea: CGRect) {
        self.boardObjects.scale(from: area, to: newArea)
        self.area = newArea
    }

    mutating func add(boardObject: any BoardObject) {
        self.boardObjects.add(boardObject: boardObject)
    }

    mutating func remove(boardObject: any BoardObject) {
        self.boardObjects.remove(boardObject: boardObject)
    }
}
