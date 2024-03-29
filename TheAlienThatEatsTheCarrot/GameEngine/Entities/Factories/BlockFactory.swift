//
//  BlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class BlockFactory: EntityFactory {
    let boardObject: Block
    let entity: Entity

    init(from boardObject: Block, to entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    func createComponents() -> [Component] {
        []
    }
}
