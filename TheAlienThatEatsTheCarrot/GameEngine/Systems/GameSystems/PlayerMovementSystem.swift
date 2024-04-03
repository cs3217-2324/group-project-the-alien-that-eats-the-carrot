//
//  PlayerMovementSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class PlayerMovementSystem: System {
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
            updateJumpState(for: player)
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
            break
        }
    }

    private func updateJumpState(for player: PlayerComponent) {
        guard
            let jumpStateComponent = nexus.getComponent(of: JumpStateComponent.self, for: player.entity),
            let physicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: player.entity) else {
            return
        }
        // TODO: add a system that modifies canJump if the player is standing on an object
        // This can either be in the physics system or a separate system
        if jumpStateComponent.isGrounded {
            jumpStateComponent.remainingJump = jumpStateComponent.maxJump
        }
    }

    private func applyPhysicsBasedOnControlAction(for player: PlayerComponent) {
        switch player.action {
        case .idle:
            doNothing()
        case .jump:
            jumpIfPlayerHasJumpsAvailable(for: player)
        case .left:
            addHorizontalForce(for: player, force: ControlAction.DEFAULT_LEFT_FORCE)
        case .right:
            addHorizontalForce(for: player, force: ControlAction.DEFAULT_RIGHT_FORCE)
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
        // do nothing
    }

    private func jumpIfPlayerHasJumpsAvailable(for player: PlayerComponent) {
        guard
            let physicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: player.entity),
            let jumpStateComponent = nexus.getComponent(of: JumpStateComponent.self, for: player.entity) else {
            return
        }
        if jumpStateComponent.remainingJump > 0 {
            physicsComponent.physicsBody.applyForce(ControlAction.DEFAULT_JUMP_FORCE)
            jumpStateComponent.isGrounded = false
            jumpStateComponent.remainingJump -= 1
        }
    }

    private func addHorizontalForce(for player: PlayerComponent, force: CGVector) {
        guard
            let physicsComponent = nexus.getComponent(of: PhysicsComponent.self, for: player.entity),
            let jumpStateComponent = nexus.getComponent(of: JumpStateComponent.self, for: player.entity) else {
            return
        }
        if jumpStateComponent.isGrounded {
            physicsComponent.physicsBody.applyForce(force)
        }
    }
}
