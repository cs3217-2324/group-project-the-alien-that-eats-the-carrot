//
//  AttackPowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class AttackPowerupEffect: ActivatePowerupEffect {
    static let DEFAULT_DURATION = 10.0
    var attackStyle: AttackStyle
    var duration: CGFloat

    init(attackStyle: AttackStyle, duration: CGFloat = AttackPowerupEffect.DEFAULT_DURATION) {
        self.attackStyle = attackStyle
        self.duration = duration
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: collider) else {
            return
        }
        attackableComponent.addAttackStyle(attackStyle)
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }
}
