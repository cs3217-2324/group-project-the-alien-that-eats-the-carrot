//
//  HeartGameCollectable.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class HeartGameCollectable: GameCollectable {
    func effectToEntity(_ entity: Entity, delegate: CollectableActionDelegate) {
        guard let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: entity) else {
            return
        }
        let newLives = destroyableComponent.lives + 1
        destroyableComponent.lives = max(newLives, destroyableComponent.maxLives)
    }
}
