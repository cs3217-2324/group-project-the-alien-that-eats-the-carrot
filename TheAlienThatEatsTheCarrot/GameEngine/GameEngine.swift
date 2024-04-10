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
    let physicsWorld = PhysicsWorld()

    let gameMode: GameMode = .normal

    init(level: Level) {
        self.systems = []
        initGameSystems()
        initGameEntities(from: level.boardObjects.allObjects)

        EventManager.shared.postEvent(GameStartEvent())
        print("Game started")
    }

    func update(deltaTime: CGFloat) {
        updateSystems(deltaTime: deltaTime)
    }

    func getRenderableComponents() -> [RenderableComponent] {
        nexus.getComponents(of: RenderableComponent.self)
    }

    func getGameStats() -> GameStats {
        createGameStatsFromECS()
    }

    private func updateSystems(deltaTime: CGFloat) {
        systems.forEach { $0.update(deltaTime: deltaTime) }
    }

    // Note that PhysicsSystem < CollisionSystem, CollisionSystem at the end
    // This is so that PhysicsSystem can update the positions, and if collision occur
    // The other systems can handle the side effects (eg. deal damage, add score etc.)
    // Before the collision is resolved by the CollisionSystem
    // PlayerMovementSystem < PhysicsSystem to prevent jump state bug
    private func initGameSystems() {
        self.systems = [PlayerMovementSystem(nexus: nexus),
                        PhysicsSystem(nexus: nexus, physicsWorld: physicsWorld),
                        MovementSystem(nexus: nexus),
                        CollectableSystem(nexus: nexus),
                        TimerSystem(nexus: nexus),
                        CameraSystem(nexus: nexus),
                        DamageSystem(nexus: nexus),
                        FrictionalSystem(nexus: nexus),
                        CreateNewEntitiesSystem(nexus: nexus),
                        CollisionSystem(nexus: nexus, physicsWorld: physicsWorld)]
    }

    private func initGameEntities(from boardObjects: [any BoardObject]) {
        let gameSettings = getGameSettings(gameMode: .normal)
        nexus.addGameSettings(for: gameSettings)
        for boardObject in boardObjects {
            nexus.addEntity(from: boardObject)
        }
    }

    private func getGameSettings(gameMode: GameMode) -> GameSettings {
        switch gameMode {
        case .normal:
            return NormalGameSettings()
        }
    }
}
