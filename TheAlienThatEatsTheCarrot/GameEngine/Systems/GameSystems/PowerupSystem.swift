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
        let canUsePowerupComponents = nexus.getComponents(of: CanUsePowerupComponent.self)
        for powerupComponent in powerupComponents {
            for canUsePowerupComponent in canUsePowerupComponents {
                guard
                    let powerupRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: powerupComponent.entity),
                    let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: canUsePowerupComponent.entity) else {
                    continue
                }
                if renderableComponent.overlapsWith(powerupRenderableComponent)
                    && canUsePowerupComponent.canUse(powerupComponent.powerupType) {
                    powerupComponent.activatePowerupForEntity(canUsePowerupComponent.entity, delegate: self)
                    nexus.removeComponent(powerupRenderableComponent, from: powerupComponent.entity)
                }
            }
        }
    }
}

extension PowerupSystem: PowerupActionDelegate {
    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

    func getComponents<T: Component>(of type: T.Type) -> [T] {
        nexus.getComponents(of: type)
    }

    func addComponent<T: Component>(_ component: T, to entity: Entity) {
        nexus.addComponent(component, to: entity)
    }
}
