//
//  NormalBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class NormalBlockFactory: BlockFactory {
    override func createComponents() -> [Component] {
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .block(.normal))
        return [blockComponent, renderableComponent]
    }
}
