//
//  MeleeAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class MeleeAttackStyle: AttackStyle, HasCoolDown {
    static let DEFAULT_COOLDOWN_DURATION = 0.3
    static let DEFAULT_KNOCKBACK_STRENGTH = 10_000.0
    let acceptableAttackDirections: [Direction]
    var targetables: [Component.Type]
    var knockbackStrength: CGFloat
    var isCoolingDown = false
    var coolDownDuration: CGFloat

    init(acceptableAttackDirections: [Direction] = [.left, .right],
         targetables: [Component.Type],
         knockbackStrength: CGFloat = MeleeAttackStyle.DEFAULT_KNOCKBACK_STRENGTH,
         cooldownDuration: CGFloat = MeleeAttackStyle.DEFAULT_COOLDOWN_DURATION) {
        self.acceptableAttackDirections = acceptableAttackDirections
        self.targetables = targetables
        self.knockbackStrength = knockbackStrength
        self.coolDownDuration = cooldownDuration
    }

    func attack(damage: CGFloat, attacker: Entity, attackee: Entity,
                delegate: AttackableDelegate) {
        if attacker != attackee
            && canAttack(attackee, with: targetables, using: delegate)
            && !isCoolingDown {
            for direction in acceptableAttackDirections
            where isAttacker(attacker, attacking: attackee, from: direction, delegate: delegate) {
                dealDamage(damage, to: attackee, delegate: delegate)
                applyKnockback(from: attacker, to: attackee, direction: direction, delegate: delegate)
                setCoolDown(for: attacker, delegate: delegate)
                break
            }
        }
    }

    private func isAttacker(_ attacker: Entity, attacking attackee: Entity,
                            from direction: Direction, delegate: AttackableDelegate) -> Bool {
        guard let attackerPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attacker),
              let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return false
        }
        if attackerPhysicsComponent.physicsBody.isCollidingWith(attackeePhysicsComponent.physicsBody,
                                                                on: direction) {
            return true
        }
        return false
    }

    private func applyKnockback(from attacker: Entity, to attackee: Entity,
                                direction: Direction, delegate: AttackableDelegate) {
        guard let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return
        }
        let forceDirection = CGVector(dx: cos(direction.vectorAngle), dy: sin(direction.vectorAngle))
        let force = forceDirection * knockbackStrength
        attackeePhysicsComponent.physicsBody.applyForce(force)
    }
}

extension Direction {
    var vectorAngle: CGFloat {
        switch self {
        case .left:
            return 0
        case .right:
            return CGFloat.pi
        case .up:
            return CGFloat.pi / 2
        case .down:
            return 3 * CGFloat.pi / 2
        }
    }
}
