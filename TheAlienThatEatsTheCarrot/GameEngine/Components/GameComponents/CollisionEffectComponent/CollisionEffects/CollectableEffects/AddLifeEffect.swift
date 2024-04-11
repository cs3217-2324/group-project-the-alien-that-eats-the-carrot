//
//  AddLifeEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class AddLifeEffect: CollisionEffect {
    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: collider) else {
            return
        }
        destroyableComponent.incrementLifeIfPossible()
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }
}
