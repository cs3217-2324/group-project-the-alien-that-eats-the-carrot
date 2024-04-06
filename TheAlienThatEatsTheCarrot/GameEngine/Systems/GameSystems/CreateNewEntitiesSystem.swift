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

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer = createPowerupObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func subscribeToEvents() {
        createPowerupObserver = EventManager.shared.subscribe(to: CreatePowerupEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let createPowerupEvent = event as? CreatePowerupEvent else {
            return
        }
        let powerup = Powerup(powerupType: createPowerupEvent.powerupType, position: createPowerupEvent.position)
        self?.nexus.addEntity(from: powerup)
    }

    func update(deltaTime: CGFloat) {
        // Do nothing
    }
}
