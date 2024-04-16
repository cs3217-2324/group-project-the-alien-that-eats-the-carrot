//
//  DoubleJumpPowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class DoubleJumpPowerupEffect: ActivatePowerupEffect {
    static let DEFAULT_DURATION = 10.0
    var duration: CGFloat

    init(duration: CGFloat = DoubleJumpPowerupEffect.DEFAULT_DURATION) {
        self.duration = duration
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard let jumpStateComponent = delegate.getComponent(of: JumpStateComponent.self, for: collider) else {
            return
        }
        jumpStateComponent.maxJump *= 2
        EventManager.shared.postEvent(PowerupActivateEvent(type: .doubleJump, name: "Double Jump 🪽"))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }
}
