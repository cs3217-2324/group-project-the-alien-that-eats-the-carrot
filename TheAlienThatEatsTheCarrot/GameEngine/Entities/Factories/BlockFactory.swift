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

class NormalBlockFactory: BlockFactory {
    override func createComponents() -> [Component] {
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position)
        return [blockComponent, renderableComponent]
    }
}

class GroundBlockFactory: BlockFactory {
    override func createComponents() -> [Component] {
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position)
        return [blockComponent, renderableComponent]
    }
}
