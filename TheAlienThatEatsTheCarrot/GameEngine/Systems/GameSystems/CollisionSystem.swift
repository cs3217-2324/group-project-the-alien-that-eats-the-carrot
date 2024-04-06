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
        handleCollisionEffects()
        // Strategy used from https://gamedev.stackexchange.com/questions/16813/handling-collisions-with-ground
        // If a physics body is standing on the ground (block) with negligible y speed, we disable gravity and
        // skip collision resolution with that ground
        let toIgnore = getToIgnoresAndHandleGroundedPhysicsBodies()
        let allPhysicsBodies = nexus.getComponents(of: PhysicsComponent.self).map { $0.physicsBody }
        physicsWorld.resolveCollisions(for: allPhysicsBodies, deltaTime: deltaTime, toIgnore: toIgnore)
    }

    func handleCollisionEffects() {
        let collisionEffectComponents = nexus.getComponents(of: CollisionEffectComponent.self)
        let dynamicPhysicsComponents = nexus.getComponents(of: PhysicsComponent.self).filter { $0.physicsBody.isDynamic }
        for collisionEffectComponent in collisionEffectComponents {
            for dynamicPhysicsComponent in dynamicPhysicsComponents {
                collisionEffectComponent.handleEffectIfCollides(with: collisionEffectComponent.entity,
                                                                by: dynamicPhysicsComponent.entity,
                                                                delegate: self)
            }
        }
    }

    private func getToIgnoresAndHandleGroundedPhysicsBodies() -> Set<[PhysicsBody]> {
        var toIgnore: Set<[PhysicsBody]> = Set()
        let physicsComponents = nexus.getComponents(of: PhysicsComponent.self)
        let groundPhysicsComponents = physicsComponents.filter {
            nexus.containsComponent(for: $0.entity, of: BlockComponent.self)
        }
        let dynamicComponents = physicsComponents.filter {
            $0.physicsBody.isDynamic
        }
        for dynamicComponent in dynamicComponents {
            var isCollidingWithGround = false
            for groundPhysicsComponent in groundPhysicsComponents {
                if dynamicComponent.physicsBody.isCollidingWith(groundPhysicsComponent.physicsBody, on: Direction.up)
                    && dynamicComponent.physicsBody.hasNegligibleYVelocity() {
                    disableGravity(for: dynamicComponent)
                    resetJumpState(for: dynamicComponent)
                    isCollidingWithGround = true
                    toIgnore.insert([dynamicComponent.physicsBody, groundPhysicsComponent.physicsBody])
                } else if !dynamicComponent.physicsBody.hasNegligibleYVelocity() {
                    restoreGravityAndUpdateJumpState(for: dynamicComponent)
                }
            }
            if !isCollidingWithGround {
                restoreGravityAndUpdateJumpState(for: dynamicComponent)
            }
        }
        return toIgnore
    }

    private func disableGravity(for physicsComponent: PhysicsComponent) {
        physicsComponent.physicsBody.velocity.dy = 0
        physicsComponent.disableGravity = true
    }

    private func resetJumpState(for physicsComponent: PhysicsComponent) {
        guard let jumpStateComponent = nexus.getComponent(of: JumpStateComponent.self, for: physicsComponent.entity) else {
            return
        }
        jumpStateComponent.setIsGrounded()
    }

    private func restoreGravityAndUpdateJumpState(for physicsComponent: PhysicsComponent) {
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

extension CollisionSystem: CollisionEffectDelegate {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T? {
        nexus.getComponent(of: type, for: entity)
    }

    func containsAnyComponent(of types: [Component.Type], in entity: Entity) -> Bool {
        nexus.containsAnyComponent(of: types, in: entity)
    }
}

extension PhysicsBody {
    static let NEGLIGIBLE_SPEED_THRESHOLD = 60.0

    func hasNegligibleYVelocity() -> Bool {
        velocity.dy.magnitude < PhysicsBody.NEGLIGIBLE_SPEED_THRESHOLD
    }
}
