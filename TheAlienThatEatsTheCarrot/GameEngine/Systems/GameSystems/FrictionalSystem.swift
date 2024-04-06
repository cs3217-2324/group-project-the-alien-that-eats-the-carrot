//
//  FrictionalSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class FrictionalSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let blockComponents = nexus.getComponents(of: BlockComponent.self)
        let physicsComponents = nexus.getComponents(of: PhysicsComponent.self)
        for blockComponent in blockComponents {
            for physicsComponent in physicsComponents {
                guard
                    let blockPhysicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: blockComponent.entity),
                    let frictionalComponent = nexus.getComponent(of: FrictionalComponent.self, for: blockComponent.entity)
                else {
                    continue
                }
                applyFrictionalForce(for: physicsComponent.physicsBody,
                                     on: blockPhysicsComponent.physicsBody,
                                     with: frictionalComponent.frictionalStrength)
            }
        }
    }

    private func applyFrictionalForce(for physicsBody: PhysicsBody,
                                      on blockPhysicsBody: PhysicsBody,
                                      with frictionalStrength: CGFloat) {
        if physicsBody.isCollidingWith(blockPhysicsBody, on: .up) && physicsBody.isDynamic {
            physicsBody.applyFrictionalForceInX(magnitude: frictionalStrength)
        }
    }
}
