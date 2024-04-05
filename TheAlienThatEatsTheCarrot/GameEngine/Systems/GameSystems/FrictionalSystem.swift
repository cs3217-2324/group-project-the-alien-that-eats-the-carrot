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
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for blockComponent in blockComponents {
            for playerComponent in playerComponents {
                guard
                    let blockPhysicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: blockComponent.entity),
                    let playerPhysicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: playerComponent.entity),
                    let frictionalComponent = nexus.getComponent(of: FrictionalComponent.self, for: blockComponent.entity)
                else {
                    continue
                }
                applyFrictionalForce(for: playerPhysicsComponent.physicsBody,
                                     on: blockPhysicsComponent.physicsBody,
                                     with: frictionalComponent.frictionalStrength)
            }
        }
    }

    private func applyFrictionalForce(for playerPhysicsBody: PhysicsBody,
                                      on blockPhysicsBody: PhysicsBody,
                                      with frictionalStrength: CGFloat) {
        if playerPhysicsBody.isCollidingWith(blockPhysicsBody, on: .up) {
            playerPhysicsBody.applyFrictionalForceInX(magnitude: frictionalStrength)
        }
    }
}
