//
//  JumpAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

/// Attack by jumping on the attackee, like Super Mario Bros
class JumpAttackStyle: AttackStyle {
    var targetables: [Component.Type]

    init(targetables: [Component.Type]) {
        self.targetables = targetables
    }

    func attack(damage: CGFloat, attacker: Entity, attackee: Entity,
                delegate: AttackableDelegate) {
        // TODO: Either use renderable component or physics component
        guard let attackerPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attacker),
              let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return
        }
        if attacker != attackee
            && canAttack(attackee, with: targetables, using: delegate)
            && self.isAttackerJumpingOnAttackee(attacker: attackerPhysicsComponent.physicsBody,
                                                attackee: attackeePhysicsComponent.physicsBody) {
            dealDamage(damage, to: attackee, delegate: delegate)
        }
    }

    private func isAttackerJumpingOnAttackee(attacker: PhysicsBody, attackee: PhysicsBody) -> Bool {
        attacker.isCollidingWith(attackee, on: .up) && !attacker.hasNegligibleYVelocity()
    }
}
