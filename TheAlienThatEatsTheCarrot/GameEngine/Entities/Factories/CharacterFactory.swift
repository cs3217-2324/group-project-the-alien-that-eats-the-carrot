//
//  CharacterFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class CharacterFactory: EntityFactory {
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
