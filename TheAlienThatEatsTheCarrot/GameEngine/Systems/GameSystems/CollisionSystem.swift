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
        let physicsComponentsToDisableGravity = getPhysicsComponentsToDisableGravity()
        disableGravity(for: physicsComponentsToDisableGravity)
        let physicsBodiesToDisableGravity = physicsComponentsToDisableGravity.map { $0.physicsBody }
        let allPhysicsBodies = nexus.getComponents(of: PhysicsComponent.self).map { $0.physicsBody }
        let physicsBodiesToResolveCollisions = allPhysicsBodies.filter { !physicsBodiesToDisableGravity.contains($0) }
        physicsWorld.resolveCollisions(for: physicsBodiesToResolveCollisions, deltaTime: deltaTime)
    }

    func lateUpdate(deltaTime: CGFloat) {
        nexus.removeComponents(of: CollisionComponent.self)
    }

    private func getPhysicsComponentsToDisableGravity() -> [PhysicsComponent] {
        var toDisable: [PhysicsComponent] = []
        let physicsComponents = nexus.getComponents(of: PhysicsComponent.self)
        let groundPhysicsComponents = physicsComponents.filter {
            nexus.containsComponent(for: $0.entity, of: BlockComponent.self)
        }
        let notGroundPhysicsComponents = physicsComponents.filter {
            !nexus.containsComponent(for: $0.entity, of: BlockComponent.self)
        }
        for notGroundPhysicsComponent in notGroundPhysicsComponents {
            for groundPhysicsComponent in groundPhysicsComponents {
                if notGroundPhysicsComponent.physicsBody.isCollidingWith(groundPhysicsComponent.physicsBody, on: Direction.up)
                    && notGroundPhysicsComponent.physicsBody.hasNegligibleYVelocity() {
                    toDisable.append(notGroundPhysicsComponent)
                } else if !notGroundPhysicsComponent.physicsBody.hasNegligibleYVelocity() {
                    restoreGravity(for: notGroundPhysicsComponent)
                }
            }
        }
        return toDisable
    }

    private func disableGravity(for physicsComponents: [PhysicsComponent]) {
        for physicsComponent in physicsComponents {
            if let jumpComponent = nexus.getComponent(of: JumpStateComponent.self, for: physicsComponent.entity) {
                jumpComponent.setIsGrounded()
            }
            physicsComponent.physicsBody.velocity.dy = 0
            physicsComponent.disableGravity = true
        }
    }

    private func restoreGravity(for physicsComponent: PhysicsComponent) {
        if let jumpComponent = nexus.getComponent(of: JumpStateComponent.self, for: physicsComponent.entity) {
            jumpComponent.isGrounded = false
        }
        physicsComponent.disableGravity = false
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
        return velocity.dy.magnitude < PhysicsBody.NEGLIGIBLE_SPEED_THRESHOLD
    }
}
