//
//  ActivatePowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

protocol ActivatePowerupEffect: CollisionEffect {
    var duration: CGFloat { get }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate)

    func restore()
}

class BasePowerupEffect: ActivatePowerupEffect {
    var duration: CGFloat

    private var powerupElapseObserver: NSObjectProtocol?

    init(duration: CGFloat) {
        self.duration = duration
    }

    deinit {
        if let observer = powerupElapseObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
    }

    func subscribeToEvents() {
        powerupElapseObserver = EventManager.shared.subscribe(to: PowerupElapseEvent.self, using: onEventOccur)
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        // Do nothing
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let powerupElapseEvent = event as? PowerupElapseEvent else {
            return
        }
        powerupElapseEvent.powerup.restore()
    }

    func restore() {
        // Do nothing
    }
}
