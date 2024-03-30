//
//  CoinCollectableFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class CoinCollectableFactory: CollectableFactory {
    override func createComponents() -> [Component] {
        let collectableComponent = CollectableComponent(entity: entity, collectable: CoinGameCollectable())
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .collectable(.coin))
        return [collectableComponent, renderableComponent]
    }
}
