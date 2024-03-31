//
//  ScoreSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

class ScoreSystem: System {
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

    func update(deltaTime: CGFloat) {
        <#code#>
    }

    func subscribeToEvents() {
        destroyObserver = EventManager.shared.subscribe(to: DestroyEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let strongSelf = self,
              let destroyEvent = event as? DestroyEvent else {
            return
        }
        strongSelf.addScoreForDestroying(destroyEvent.entity)
    }

    private func addScoreForDestroying(_ entity: Entity) {
        guard let scoreComponent = nexus.getComponent(of: ScoreComponent.self, for: entity) else {
            return
        }
        EventManager.shared.postEvent(AddScoreEvent(score: scoreComponent.score))
    }
}
