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

        EventManager.shared.postEvent(GameStartEvent())
        print("Game started")
    }

    func update(deltaTime: CGFloat) {
        updateSystems(deltaTime: deltaTime)
    }

    func updatePlayersMovement(player: PlayerRole, action: ControlAction) {
        switch player {
        case .one:
            guard let playerEntity = nexus.getEntity(with: PlayerComponent.self) else {
                return
            }
            updateAction(action, of: playerEntity)
        case .two:
            guard let playerEntity = nexus.getEntity(with: PlayerComponent.self) else {
                return
            }
            updateAction(action, of: playerEntity)
        }
    }

    func getRenderableComponents() -> [RenderableComponent] {
        nexus.getComponents(of: RenderableComponent.self)
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
        self.systems = [PlayerSystem(nexus: nexus), MovementSystem(nexus: nexus), CameraSystem(nexus: nexus)]
    }

    private func initGameEntities() {
        nexus.addCharacterForPlayerA()
        nexus.addEntity(type: .enemy(.normal))
    }
}
