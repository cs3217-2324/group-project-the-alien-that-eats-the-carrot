//
//  GroundBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class GroundBlockFactory: BlockFactory {
    override func createComponents() -> [Component] {
        let blockComponent = BlockComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .block(.ground))
        return [blockComponent, renderableComponent]
    }
}
