//
//  PeriodicallyShootPelletAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class PeriodicallyShootPelletAttackStyle: AttackStyle, HasCoolDown {
    static let DEFAULT_PELLET_SPEED = 1_000.0
    static let DEFAULT_COOLDOWN_DURATION = 1.0
    static let DEFAULT_DAMAGE: CGFloat = .zero
    var targetables: [Component.Type]
    var coolDownDuration: CGFloat
    var directions: [Direction]
    var damage: CGFloat
    var speed: CGFloat
    var isCoolingDown = false
    var dissapearWhenCollideWith: [Component.Type]

    init(targetables: [Component.Type],
         directions: [Direction],
         dissapearWhenCollideWith: [Component.Type],
         damage: CGFloat = PeriodicallyShootPelletAttackStyle.DEFAULT_DAMAGE,
         cooldownDuration: CGFloat = PeriodicallyShootPelletAttackStyle.DEFAULT_COOLDOWN_DURATION,
         speed: CGFloat = PeriodicallyShootPelletAttackStyle.DEFAULT_PELLET_SPEED) {
        self.targetables = targetables
        self.coolDownDuration = cooldownDuration
        self.directions = directions
        self.damage = damage
        self.speed = speed
        self.dissapearWhenCollideWith = dissapearWhenCollideWith
    }

    func attack(attacker: Entity, attackee: Entity, delegate: AttackableDelegate) {
        guard attacker != attackee,
              canAttack(attackee, with: targetables, using: delegate),
              !isCoolingDown,
              let shooterPhysicsBody = delegate.getComponent(of: PhysicsComponent.self, for: attacker) else {
            return
        }
        for direction in directions {
            let pelletVelocity = getVelocity(direction: direction, speed: speed)
            let createPelletEvent = CreateProjectileEvent(projectileType: .pellet,
                                                          position: shooterPhysicsBody.physicsBody.position,
                                                          velocity: pelletVelocity,
                                                          targetables: targetables,
                                                          dissapearWhenCollideWith: dissapearWhenCollideWith)
            EventManager.shared.postEvent(createPelletEvent)
        }
        setCoolDown(for: attacker, delegate: delegate)
    }

    private func getVelocity(direction: Direction, speed: CGFloat) -> CGVector {
        switch direction {
        case .up:
            return CGVector(dx: 0, dy: -speed)
        case .down:
            return CGVector(dx: 0, dy: speed)
        case .left:
            return CGVector(dx: -speed, dy: 0)
        case .right:
            return CGVector(dx: speed, dy: 0)
        }
    }
}
