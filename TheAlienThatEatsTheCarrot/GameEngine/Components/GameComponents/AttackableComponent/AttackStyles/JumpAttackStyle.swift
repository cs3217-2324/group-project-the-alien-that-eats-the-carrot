//
//  JumpAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

/// Attack by jumping on the attackee, like Super Mario Bros
class JumpAttackStyle: AttackStyle {
    func attack(damage: CGFloat, attacker: Entity, attackee: Entity,
                targetables: [Component.Type], delegate: AttackableDelegate) {
        // TODO: Either use renderable component or physics component
        guard let attackerPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attacker),
              let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return
        }
        // TODO: replace this with the actual check to see whether the bottom of attacker is colliding with top of attackee
        let isAttackerJumpingOnAttackee = false
        if attacker != attackee
            && canAttack(attackee, with: targetables, using: delegate)
            && isAttackerJumpingOnAttackee {
            dealDamage(damage, to: attackee, delegate: delegate)
        }
    }
}
