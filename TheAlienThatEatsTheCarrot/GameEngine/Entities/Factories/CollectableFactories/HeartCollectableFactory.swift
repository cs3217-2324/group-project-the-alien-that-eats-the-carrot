//
//  HeartCollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class HeartCollectableFactory: CollectableFactory {
    override func createComponents() -> [Component] {
        let collectableComponent = CollectableComponent(entity: entity, collectable: HeartGameCollectable())
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .collectable(.heart))
        return [collectableComponent, renderableComponent]
    }
}
