//
//  PlayerPowerupSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

/// This system is responsible for checking if the powerups are being consumed
class PlayerPowerupSystem: System {
    var nexus: Nexus
    private var powerupElapseOserver: NSObjectProtocol?

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer = powerupElapseOserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func subscribeToEvents() {
        powerupElapseOserver = EventManager.shared.subscribe(to: PowerupElapseEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let powerupElapseEvent = event as? PowerupElapseEvent else {
            return
        }
        powerupElapseEvent.powerup.restoreDefault()
    }

    func update(deltaTime: CGFloat) {
        let powerupComponents = nexus.getComponents(of: PowerupComponent.self)
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for powerupComponent in powerupComponents {
            for playerComponent in playerComponents {
                guard
                    let powerupRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: powerupComponent.entity),
                    let playerRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: playerComponent.entity) else {
                    continue
                }
                if playerRenderableComponent.overlapsWith(powerupRenderableComponent) {
                    powerupComponent.activatePowerupForEntity(playerComponent.entity, delegate: self)
                    nexus.removeComponent(powerupRenderableComponent, from: powerupComponent.entity)
                }
            }
        }
    }
}

extension PlayerPowerupSystem: PowerupActionDelegate {
    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

    func addComponent<T: Component>(_ component: T, to entity: Entity) {
        nexus.addComponent(component, to: entity)
    }
}
