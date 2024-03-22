//
//  BlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class BlockFactory: EntityFactory {
    func createComponents() -> [Component] {
        return []
    }
}

class NormalBlockFactory: BlockFactory {
    let boardObject: NormalBlock
    let entity: Entity

    init(from boardObject: NormalBlock, to entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    override func createComponents() -> [Component] {
        let blockComponent = BlockComponent(entity: entity)
        let positionalComponent = PositionalComponent(entity: entity, position: boardObject.position)
        return [blockComponent, positionalComponent]
    }
}

class GroundBlockFactory: BlockFactory {
    let boardObject: GroundBlock
    let entity: Entity

    init(from boardObject: GroundBlock, to entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    override func createComponents() -> [Component] {
        let blockComponent = BlockComponent(entity: entity)
        let positionalComponent = PositionalComponent(entity: entity, position: boardObject.position)
        return [blockComponent, positionalComponent]
    }
}
