//
//  CollectableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class CollectableComponent: Component {
    var entity: Entity
    var collectable: GameCollectable

    init(entity: Entity, collectable: GameCollectable) {
        self.entity = entity
        self.collectable = collectable
    }

    func collectCollectableForEntity(_ entity: Entity, delegate: CollectableActionDelegate) {
        collectable.effectToEntity(entity, delegate: delegate)
    }
}
