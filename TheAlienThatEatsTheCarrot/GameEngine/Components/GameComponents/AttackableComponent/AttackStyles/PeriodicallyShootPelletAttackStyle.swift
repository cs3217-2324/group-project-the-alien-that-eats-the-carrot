//
//  PeriodicallyShootPelletAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class PeriodicallyShootPelletAttackStyle: AttackStyle {
    static let DEFAULT_PELLET_SPEED = 50.0
    var targetables: [Component.Type]
    var interval: CGFloat
    var directions: [Direction]
    var speed: CGFloat

    init(targetables: [Component.Type],
         interval: CGFloat,
         directions: [Direction],
         speed: CGFloat = PeriodicallyShootPelletAttackStyle.DEFAULT_PELLET_SPEED) {
        self.targetables = targetables
        self.interval = interval
        self.directions = directions
        self.speed = speed
    }

    func attack(damage: CGFloat, attacker: Entity, attackee: Entity, delegate: AttackableDelegate) {
        guard attacker != attackee,
              canAttack(attackee, with: targetables, using: delegate),
              let shooterPhysicsBody = delegate.getComponent(of: PhysicsComponent.self, for: attacker) else {
            return
        }
        for direction in directions {
            let pelletVelocity = getVelocity(direction: direction, speed: speed)
            let createPelletEvent = CreateProjectileEvent(projectileType: .pellet,
                                                          position: shooterPhysicsBody.physicsBody.position,
                                                          velocity: pelletVelocity,
                                                          targetables: targetables)
            EventManager.shared.postEvent(createPelletEvent)
        }
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
            return CGVector(dx: 0, dy: speed)
        }
    }
}
