//
//  InvinciblePowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class InvinciblePowerupEffect: ActivatePowerupEffect {
    static let DEFAULT_DURATION = 7.0
    var duration: CGFloat

    private var destroyableComponentAffected: DestroyableComponent?

    init(duration: CGFloat = InvinciblePowerupEffect.DEFAULT_DURATION) {
        self.duration = duration
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard
            let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: collider),
            let colliderPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collider) else {
            return
        }
        destroyableComponent.isInvinsible = true
        destroyableComponentAffected = destroyableComponent
        EventManager.shared.postEvent(PowerupActivateEvent(type: .invinsible,
                                                           name: "Invinsible 😇",
                                                           position: colliderPhysicsComponent.physicsBody.position))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }

    func restore() {
        destroyableComponentAffected?.isInvinsible = false
    }
}
