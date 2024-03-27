//
//  ControllableSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class PlayerSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for player in playerComponents {
            applyPhysicsBasedOnControlAction(for: player)
            player.action = .idle
        }
    }

    private func applyPhysicsBasedOnControlAction(for player: PlayerComponent) {
        switch player.action {
        case .idle:
            print("Do nothing")
        case .jump:
            print("Apply upward force to player entity")
        case .left:
            print("Apply leftward velocity")
        case .right:
            print("Apply rightward velocity")
        }
    }
}
