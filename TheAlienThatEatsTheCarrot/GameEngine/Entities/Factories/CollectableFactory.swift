//
//  CollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class CollectableFactory: EntityFactory {
    let boardObject: BoardObject
    let entity: Entity

    init(boardObject: BoardObject, entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    func createComponents() -> [Component] {
        []
    }
}
