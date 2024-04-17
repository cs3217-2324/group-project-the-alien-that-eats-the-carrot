//
//  AttackPowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class AttackPowerupEffect: BasePowerupEffect {
    static let DEFAULT_DURATION = 8.0
    var attackStyle: AttackStyle

    private var attackableComponentAffected: AttackableComponent?
    private var attackStyleAdded: AttackStyle?

    init(attackStyle: AttackStyle, duration: CGFloat = AttackPowerupEffect.DEFAULT_DURATION) {
        self.attackStyle = attackStyle
        super.init(duration: duration)
    }

    override func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard
            let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: collider),
            let colliderPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collider) else {
            return
        }
        attackableComponent.addAttackStyle(attackStyle)
        attackableComponentAffected = attackableComponent
        attackStyleAdded = attackStyle
        super.addTimer(to: collider, powerupEffect: self, delegate: delegate)
        EventManager.shared.postEvent(PowerupActivateEvent(type: .attack,
                                                           name: "Attack 🔪",
                                                           position: colliderPhysicsComponent.physicsBody.position))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }

    override func restore() {
        guard let attackStyleToRemove = attackStyleAdded else {
            return
        }
        attackableComponentAffected?.removeAttackStyle(attackStyleToRemove)
    }
}
