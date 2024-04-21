//
//  MovementSystems.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovementSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let movableComponents = nexus.getComponents(of: MovableComponent.self)
        let physicsBodies = nexus.getComponents(of: PhysicsComponent.self).map { $0.physicsBody }
        let jumpStateComponents = nexus.getComponents(of: JumpStateComponent.self)
        for movable in movableComponents {
            movable.moveBasedOnPattern(deltaTime: deltaTime, delegate: self)
        }
        for physicsBody in physicsBodies {
            for jumpStateComponent in jumpStateComponents {
                resetJumpState(for: jumpStateComponent, ifSteppingOn: physicsBody)
            }
        }
    }

    private func resetJumpState(for jumpStateComponent: JumpStateComponent,
                                ifSteppingOn physicsBody: PhysicsBody) {
        guard let jumperPhysicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: jumpStateComponent.entity) else {
            return
        }
        if jumperPhysicsComponent.physicsBody.isCollidingWith(physicsBody, on: .up) {
            jumpStateComponent.setIsGrounded()
        }
    }
}

extension MovementSystem: MovableDelegate {
    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

    func getComponents<T>(of type: T.Type) -> [T] where T: Component {
        nexus.getComponents(of: type)
    }

    func containsAnyComponent(of types: [Component.Type], in entity: Entity) -> Bool {
        nexus.containsAnyComponent(of: types, in: entity)
    }
}
