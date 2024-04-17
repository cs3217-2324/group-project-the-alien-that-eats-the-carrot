//
//  JumpAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

/// Attack by jumping on the attackee, like Super Mario Bros
class JumpAttackStyle: AttackStyle {
    static let DEFAULT_JUMP_ATTACK_DAMAGE = 100.0
    var targetables: [Component.Type]
    var damage: CGFloat

    init(targetables: [Component.Type], damage: CGFloat = JumpAttackStyle.DEFAULT_JUMP_ATTACK_DAMAGE) {
        self.targetables = targetables
        self.damage = damage
    }

    func attack(attacker: Entity, attackee: Entity,
                delegate: AttackableDelegate) {
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
        attacker.isCollidingWith(attackee, on: .up)
    }
}
