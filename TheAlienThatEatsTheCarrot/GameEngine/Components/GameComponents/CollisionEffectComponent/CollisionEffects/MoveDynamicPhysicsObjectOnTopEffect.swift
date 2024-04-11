//
//  MoveDynamicPhysicsObjectOnTopEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class MoveDynamicPhysicsObjectOnTopEffect: CollisionEffect {
    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard let colliderPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collider),
              let collideePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collidee) else {
            return
        }
        if !colliderPhysicsComponent.physicsBody.isDynamic {
            return
        }
        let collideeVelocity = collideePhysicsComponent.physicsBody.velocity
        let FORCE_OFFSET = CGVector(dx: collideeVelocity.dx.sign * 450, dy: 0)
        colliderPhysicsComponent.physicsBody.applyForce(FORCE_OFFSET)
    }
}
