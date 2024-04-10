//
//  HeartCollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class HeartCollectableFactory: CollectableFactory {
    override func createComponents() -> [Component] {
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let collectableComponent = CollectableComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .collectable(.heart),
                                                      size: size)
        return [collectableComponent, renderableComponent]
    }
}
