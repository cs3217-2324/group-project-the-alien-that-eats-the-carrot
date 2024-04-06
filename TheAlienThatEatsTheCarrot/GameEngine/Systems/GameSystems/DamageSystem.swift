//
//  DamageSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class DamageSystem: System {
    var nexus: Nexus
    private var destroyObserver: NSObjectProtocol?
    private var liveDecreaseObserver: NSObjectProtocol?

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer1 = destroyObserver {
            EventManager.shared.unsubscribe(from: observer1)
        }
        if let observer2 = liveDecreaseObserver {
            EventManager.shared.unsubscribe(from: observer2)
        }
    }

    func subscribeToEvents() {
        destroyObserver = EventManager.shared.subscribe(to: DestroyEvent.self, using: onDestroyEventOccur)
        liveDecreaseObserver = EventManager.shared.subscribe(to: LiveDecreaseEvent.self, using: onLiveDecreaseEventOccur)
    }

    private lazy var onDestroyEventOccur = { [weak self] (event: Event) -> Void in
        guard let destroyEvent = event as? DestroyEvent else {
            return
        }
        self?.handleDestroyEvent(for: destroyEvent.entity)
    }

    private lazy var onLiveDecreaseEventOccur = { [weak self] (event: Event) -> Void in
        guard let liveDecreaseEvent = event as? LiveDecreaseEvent else {
            return
        }
        self?.handleRespawnIfNecessary(for: liveDecreaseEvent.entity)
    }

    func update(deltaTime: CGFloat) {
        let attackableComponents = nexus.getComponents(of: AttackableComponent.self)
        let destroyableComponents = nexus.getComponents(of: DestroyableComponent.self)
        for attackableComponent in attackableComponents {
            for destroyableComponent in destroyableComponents {
                attackableComponent.attackIfPossible(attackee: destroyableComponent.entity, delegate: self)
            }
        }
    }

    private func handleDestroyEvent(for entity: Entity) {
        if nexus.containsAnyComponent(of: [PlayerComponent.self], in: entity) {
            print("Player died!")
        }
    }

    private func handleRespawnIfNecessary(for entity: Entity) {
        guard
            let respawnableComponent = nexus.getComponent(of: RespawnableComponent.self, for: entity),
            let destroyableComponent = nexus.getComponent(of: DestroyableComponent.self, for: entity)
        else {
            return
        }
        if destroyableComponent.isDestroyed {
            return
        }
        nexus.updatePosition(for: respawnableComponent.entity, to: respawnableComponent.spawnPoint)
    }
}

extension DamageSystem: AttackableDelegate {
    func addComponent<T: Component>(_ component: T, to entity: Entity) {
        nexus.addComponent(component, to: entity)
    }

    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

    func removeComponent<T: Component>(_ component: T, from entity: Entity) where T: AnyObject {
        nexus.removeComponent(component, from: entity)
    }
}
