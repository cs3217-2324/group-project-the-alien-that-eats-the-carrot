//
//  CollisionEffectComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class CollisionEffectComponent: Component {
    var entity: Entity
    var acceptableDirectionsToCollideFrom: [Direction]
    var collisionEffect: CollisionEffect

    init(entity: Entity, acceptableDirectionsToCollideFrom: [Direction], collisionEffect: CollisionEffect) {
        self.entity = entity
        self.acceptableDirectionsToCollideFrom = acceptableDirectionsToCollideFrom
        self.collisionEffect = collisionEffect
    }

    func collides(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard
            let collideePhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collidee),
            let colliderPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collider)
        else {
            return
        }
        for direction in acceptableDirectionsToCollideFrom
        where colliderPhysicsComponent.physicsBody.isCollidingWith(collideePhysicsComponent.physicsBody, on: direction) {
            collisionEffect.effectWhenCollide(with: collidee, by: collider, delegate: delegate)
            break
        }
    }
}
