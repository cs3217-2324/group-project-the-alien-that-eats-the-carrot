//
//  CarrotCollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class CarrotCollectableFactory: CollectableFactory {
    override func createComponents() -> [Component] {
        let collectableComponent = CollectableComponent(entity: entity, collectable: CarrotGameCollectable())
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .collectable(.carrot))
        return [collectableComponent, renderableComponent]
    }
}
