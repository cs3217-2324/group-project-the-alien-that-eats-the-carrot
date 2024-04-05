//
//  DamageSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class DamageSystem: System, AttackableDelegate {
    var nexus: Nexus
    private var destroyObserver: NSObjectProtocol?

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer = destroyObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func subscribeToEvents() {
        destroyObserver = EventManager.shared.subscribe(to: DestroyEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let destroyEvent = event as? DestroyEvent else {
            return
        }
        self?.handleDestroyEventFor(destroyEvent.entity)
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

    private func handleDestroyEventFor(_ entity: Entity) {
        if nexus.containsAnyComponent(of: [PlayerComponent.self], in: entity) {
            print("Player died!")
        }
    }

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
