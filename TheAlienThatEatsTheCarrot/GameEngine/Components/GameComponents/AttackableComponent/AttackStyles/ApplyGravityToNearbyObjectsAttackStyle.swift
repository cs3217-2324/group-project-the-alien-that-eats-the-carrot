//
//  ApplyGravityToNearbyObjectsAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class ApplyGravityToNearbyObjectsAttackStyle: AttackStyle {
    var targetables: [Component.Type]

    var damage: CGFloat
    var forceStrength: CGFloat
    var radius: CGFloat

    init(targetables: [Component.Type], damage: CGFloat, forceStrength: CGFloat, radius: CGFloat) {
        self.targetables = targetables
        self.damage = damage
        self.forceStrength = forceStrength
        self.radius = radius
    }

    func attack(attacker: Entity, attackee: Entity, delegate: AttackableDelegate) {
        guard let attackerPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attacker),
              let attackeePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: attackee) else {
            return
        }
        let attackerPhysicsBody = attackerPhysicsComponent.physicsBody
        let attackeePhysicsBody = attackeePhysicsComponent.physicsBody
        let distance = (attackerPhysicsBody.position - attackeePhysicsBody.position).magnitude
        if distance > radius {
            return
        }
        applyGravityTo(attackeePhysicsBody, from: distance, towards: attackerPhysicsBody.position)
    }

    private func applyGravityTo(_ attackeePhysicsBody: PhysicsBody, from distance: CGFloat, towards position: CGPoint) {
        let direction = position - attackeePhysicsBody.position
        let normalizedDirection = direction.unitVector

        let forceStrengthToBeApplied = (radius - distance) / radius * forceStrength
        let force = normalizedDirection * forceStrengthToBeApplied

        attackeePhysicsBody.applyForce(force)
    }
}
