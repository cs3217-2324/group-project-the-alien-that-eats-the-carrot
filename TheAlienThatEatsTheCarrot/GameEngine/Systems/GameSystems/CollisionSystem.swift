//
//  CollisionSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 2/4/24.
//

import CoreGraphics

final class CollisionSystem: System {
    let nexus: Nexus
    let physicsWorld: PhysicsWorld

    init(nexus: Nexus, physicsWorld: PhysicsWorld) {
        self.nexus = nexus
        self.physicsWorld = physicsWorld
        self.physicsWorld.collisionDelegate = self
    }

    func update(deltaTime: CGFloat) {
        // Strategy used from https://gamedev.stackexchange.com/questions/16813/handling-collisions-with-ground
        detectStableGroundCollision()
        let physicsBodies = nexus.getComponents(of: PhysicsComponent.self).map { $0.physicsBody }
        physicsWorld.resolveCollisions(for: physicsBodies, deltaTime: deltaTime)
    }

    func lateUpdate(deltaTime: CGFloat) {
        nexus.removeComponents(of: CollisionComponent.self)
    }

    private func detectStableGroundCollision() {
        let physicsComponents = nexus.getComponents(of: PhysicsComponent.self)
        let groundEntities = nexus.getEntities(with: BlockComponent.self)
        var groundPhysicsComponents: [PhysicsComponent] = []
        for groundEntity in groundEntities {
            guard let physicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: groundEntity) else {
                continue
            }
            groundPhysicsComponents.append(physicsComponent)
        }
        for physicsComponent in physicsComponents {
            if nexus.containsComponent(for: physicsComponent.entity, of: BlockComponent.self) {
                continue
            }
            handleCollisionWithGround(for: physicsComponent, groundPhysicsComponents: groundPhysicsComponents)
        }
    }

    private func handleCollisionWithGround(for physicsComponent: PhysicsComponent, groundPhysicsComponents: [PhysicsComponent]) {
        for groundPhysicsComponent in groundPhysicsComponents {
            if !physicsComponent.physicsBody.hasNegligibleYVelocity() {
                physicsComponent.disableGravity = false
            }
            if physicsComponent.physicsBody.isCollidingWith(groundPhysicsComponent.physicsBody, on: Direction.up)
                && physicsComponent.physicsBody.hasNegligibleYVelocity() {
                physicsComponent.physicsBody.velocity.dy = 0
                physicsComponent.disableGravity = true
            }
        }
    }
}

// MARK: PhysicsCollisionDelegate
extension CollisionSystem: PhysicsCollisionDelegate {
    func didBegin(_ collision: Collision) {
        guard
            let entityA = getEntityFromPhysicsBody(collision.bodyA),
            let entityB = getEntityFromPhysicsBody(collision.bodyB)
        else {
            return
        }

        nexus.addComponent(CollisionComponent(entity: entityA, collidedEntity: entityB), to: entityA)
        nexus.addComponent(CollisionComponent(entity: entityB, collidedEntity: entityA), to: entityB)
    }

    func didEnd(_ collision: Collision) {
    }

    private func getEntityFromPhysicsBody(_ physicsBody: PhysicsBody) -> Entity? {
        let physicsComponents = nexus.getComponents(of: PhysicsComponent.self)
        let physicsComponent = physicsComponents.first(where: { $0.physicsBody === physicsBody })

        return physicsComponent?.entity
    }
}

extension PhysicsBody {
    static let NEGLIGIBLE_SPEED_THRESHOLD = 60.0

    func hasNegligibleYVelocity() -> Bool {
        velocity.dy.magnitude < PhysicsBody.NEGLIGIBLE_SPEED_THRESHOLD
    }
}
