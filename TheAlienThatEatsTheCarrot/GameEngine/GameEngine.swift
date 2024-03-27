//
//  GameEngine.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import CoreGraphics
import Combine

class GameEngine {
    let nexus = Nexus()
    var systems: [System]

    init() {
        self.systems = []
        initGameSystems()
        initGameEntities()
    }

    func update(deltaTime: CGFloat) {
        updateSystems(deltaTime: deltaTime)
    }

    func updatePlayersMovement(player: Player, action: ControlAction) {
        switch player {
        case .A:
            guard let playerEntity = nexus.getEntity(with: PlayerAComponent.self) else {
                return
            }
            updateAction(action, of: playerEntity)
        case .B:
            guard let playerEntity = nexus.getEntity(with: PlayerBComponent.self) else {
                return
            }
            updateAction(action, of: playerEntity)
        }
    }

    private func updateAction(_ action: ControlAction, of player: Entity) {
        guard let playerComponent = nexus.getComponent(of: PlayerComponent.self, for: player) else {
            return
        }
        playerComponent.action = action
    }

    private func updateSystems(deltaTime: CGFloat) {
        systems.forEach { $0.update(deltaTime: deltaTime) }
    }

    private func initGameSystems() {
        self.systems.append(contentsOf: [MovementSystem(nexus: nexus)])
    }

    private func initGameEntities() {
        nexus.addCharacterForPlayerA()
        nexus.addEntity(type: .enemy(.normal))
    }
}
