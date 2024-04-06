//
//  CollisionEffectComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class CollisionEffectComponent: Component {
    var entity: Entity
    let acceptableDirectionsToCollideFrom: [Direction]
    let acceptableComponentsColliders: [Component.Type]
    let collisionEffect: CollisionEffect

    init(entity: Entity,
         acceptableComponentsColliders: [Component.Type],
         acceptableDirectionsToCollideFrom: [Direction],
         collisionEffect: CollisionEffect) {
        self.entity = entity
        self.acceptableComponentsColliders = acceptableComponentsColliders
        self.acceptableDirectionsToCollideFrom = acceptableDirectionsToCollideFrom
        self.collisionEffect = collisionEffect
    }

    func handleEffectIfCollides(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard
            collidee != collidee,
            delegate.containsAnyComponent(of: acceptableComponentsColliders, in: collider),
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
