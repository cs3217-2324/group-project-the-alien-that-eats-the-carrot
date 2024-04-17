//
//  StrengthPowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class StrengthPowerupEffect: BasePowerupEffect {
    static let DEFAULT_FACTOR = 3.0
    static let DEFAULT_DURATION = 10.0
    static let HEAD_STRENGTH_DAMAGE = 100.0
    var factor: CGFloat

    private var headAttackStyleAffected: HeadAttackStyle?

    init(duration: CGFloat = StrengthPowerupEffect.DEFAULT_DURATION,
         factor: CGFloat = StrengthPowerupEffect.DEFAULT_FACTOR) {
        self.factor = factor
        super.init(duration: duration)
        subscribeToEvents()
    }

    override func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        allowPlayerToDestroyBlocks(player: collider, delegate: delegate, enable: true)
        guard let colliderPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collider) else {
            return
        }
        super.addTimer(to: collider, powerupEffect: self, delegate: delegate)
        EventManager.shared.postEvent(PowerupActivateEvent(type: .strength,
                                                           name: "Strength 💪",
                                                           position: colliderPhysicsComponent.physicsBody.position))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }

    private func allowPlayerToDestroyBlocks(player: Entity, delegate: CollisionEffectDelegate, enable: Bool) {
        guard let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: player) else {
            return
        }
        guard let headAttackStyle = attackableComponent.getAttackStyle(with: HeadAttackStyle.self) else {
            return
        }
        headAttackStyleAffected = headAttackStyle
        headAttackStyle.damage = StrengthPowerupEffect.HEAD_STRENGTH_DAMAGE
    }

    override func restore() {
        headAttackStyleAffected?.damage = .zero
    }
}
