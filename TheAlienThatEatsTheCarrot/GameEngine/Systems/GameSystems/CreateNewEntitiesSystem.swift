//
//  CreateNewEntitiesSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class CreateNewEntitiesSystem: System {
    var nexus: Nexus
    private var createPowerupObserver: NSObjectProtocol?
    private var createProjectileObserver: NSObjectProtocol?
    private var removeEntityObserver: NSObjectProtocol?

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer1 = createPowerupObserver {
            EventManager.shared.unsubscribe(from: observer1)
        }
        if let observer2 = createProjectileObserver {
            EventManager.shared.unsubscribe(from: observer2)
        }
        if let observer3 = removeEntityObserver {
            EventManager.shared.unsubscribe(from: observer3)
        }
    }

    func subscribeToEvents() {
        createPowerupObserver = EventManager.shared.subscribe(to: CreatePowerupEvent.self, using: onEventOccur)
        createProjectileObserver = EventManager.shared.subscribe(to: CreateProjectileEvent.self, using: onEventOccur)
        removeEntityObserver = EventManager.shared.subscribe(to: RemoveEntityEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        if let createPowerupEvent = event as? CreatePowerupEvent {
            self?.handleCreatePowerupEvent(createPowerupEvent)
        } else if let createProjectileEvent = event as? CreateProjectileEvent {
            self?.handleCreateProjectileEvent(createProjectileEvent)
        } else if let removeEntityEvent = event as? RemoveEntityEvent {
            self?.handleRemoveEntityEvent(removeEntityEvent)
        }
    }

    private func handleCreatePowerupEvent(_ event: CreatePowerupEvent) {
        let powerup = Powerup(powerupType: event.powerupType, position: event.position)
        nexus.addEntity(from: powerup)
    }

    private func handleCreateProjectileEvent(_ event: CreateProjectileEvent) {
        nexus.addProjectile(type: event.projectileType, velocity: event.velocity,
                            position: event.position, size: event.size,
                            targetables: event.targetables)
    }

    private func handleRemoveEntityEvent(_ event: RemoveEntityEvent) {
        print("Removed entity")
        nexus.removeEntity(event.entity)
    }

    func update(deltaTime: CGFloat) {
        // Do nothing
    }
}
