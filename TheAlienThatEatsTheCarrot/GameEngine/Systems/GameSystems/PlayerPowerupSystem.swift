//
//  PowerupSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

/// This system is responsible for checking if the powerups are being consumed
class PowerupSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let powerupComponents = nexus.getComponents(of: PowerupComponent.self)
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for powerupComponent in powerupComponents {
            for playerComponent in playerComponents {
                guard
                    let powerupRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: powerupComponent.entity),
                    let playerRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: playerComponent.entity) else {
                    return
                }
                if playerRenderableComponent.overlapsWith(powerupRenderableComponent) {
                    powerupComponent.activatePowerupForEntity(playerComponent.entity)
                }
            }
        }
    }

}
