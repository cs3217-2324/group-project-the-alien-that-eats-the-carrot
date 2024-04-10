//
//  HeadAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

/// Attack by hitting with from the bottom (like how Mario break blocks from bottom)
class HeadAttackStyle: AttackStyle {
    static let DEFAULT_HEAD_ATTACK_DAMAGE: CGFloat = .zero
    var targetables: [Component.Type]
    var damage: CGFloat

    init(targetables: [Component.Type], damage: CGFloat = HeadAttackStyle.DEFAULT_HEAD_ATTACK_DAMAGE) {
        self.targetables = targetables
        self.damage = damage
    }

    func attack(attacker: Entity, attackee: Entity,
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
            print("dealing damage")
            dealDamage(damage, to: attackee, delegate: delegate)
        }
    }

    private func isAttackerJumpingOnAttackee(attacker: PhysicsBody, attackee: PhysicsBody) -> Bool {
        attacker.isCollidingWith(attackee, on: .down)
    }
}
