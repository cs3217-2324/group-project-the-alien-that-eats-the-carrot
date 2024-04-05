//
//  MovementSystems.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovementSystem: System, MovableDelegate {
    var nexus: Nexus
    private var gameStartObserver: NSObjectProtocol?

    init(nexus: Nexus) {
        self.nexus = nexus
        subscribeToEvents()
    }

    deinit {
        if let observer = gameStartObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func subscribeToEvents() {
        gameStartObserver = EventManager.shared.subscribe(to: GameStartEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        print("A Receiving event! \(event.self)")
    }

    func update(deltaTime: CGFloat) {
        let movableComponents = nexus.getComponents(of: MovableComponent.self)
        for movable in movableComponents {
            movable.moveBasedOnPattern(deltaTime: deltaTime, delegate: self)
        }
    }

    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

    func getComponents<T>(of type: T.Type) -> [T] where T : Component {
        nexus.getComponents(of: type)
    }
}
