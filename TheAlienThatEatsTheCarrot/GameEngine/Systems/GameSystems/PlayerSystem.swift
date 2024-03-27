//
//  ControllableSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class PlayerSystem: System {
    var nexus: Nexus
    private var playerControlActionObserver: NSObjectProtocol?

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer = playerControlActionObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func update(deltaTime: CGFloat) {
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for player in playerComponents {
            applyPhysicsBasedOnControlAction(for: player)
            updateCameraBasedOnNewPosition(for: player)
            resetPlayerActionIfJump(for: player)
        }
    }

    func subscribeToEvents() {
        playerControlActionObserver = EventManager.shared.subscribe(to: PlayerControlActionEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard
            let playerControlActionEvent = event as? PlayerControlActionEvent,
            let playerComponents = self?.nexus.getComponents(of: PlayerComponent.self)
        else {
            return
        }
        for playerComponent in playerComponents
        where playerComponent.playerRole == playerControlActionEvent.playerRole {
            let oldAction = playerComponent.action
            playerComponent.action = playerControlActionEvent.action
            print("changed \(oldAction) to \(playerControlActionEvent.action)")
            break
        }
    }

    private func applyPhysicsBasedOnControlAction(for player: PlayerComponent) {
        switch player.action {
        case .idle:
            doNothing()
        case .jump:
            print("Apply upward force to player entity")
        case .left:
            print("Apply leftward velocity")
        case .right:
            print("Apply rightward velocity")
        }
    }

    private func resetPlayerActionIfJump(for player: PlayerComponent) {
        if player.action == .jump {
            player.action = .idle
        }
    }

    private func updateCameraBasedOnNewPosition(for player: PlayerComponent) {
        guard
            let camera = nexus.getComponent(of: CameraComponent.self, for: player.entity),
            let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: player.entity)
        else {
            return
        }
        camera.updateCameraBoundsFromCenter(center: renderableComponent.position)
    }

    private func doNothing() {
    }
}
