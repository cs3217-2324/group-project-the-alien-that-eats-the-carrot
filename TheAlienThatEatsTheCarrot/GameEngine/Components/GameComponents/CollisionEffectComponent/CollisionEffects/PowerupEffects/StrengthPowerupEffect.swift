//
//  StrengthPowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class StrengthPowerupEffect: ActivatePowerupEffect {
    static let DEFAULT_FACTOR = 3.0
    static let DEFAULT_DURATION = 10.0
    static let HEAD_STRENGTH_DAMAGE = 100.0
    var duration: CGFloat
    var factor: CGFloat

    private var headAttackStyleAffected: HeadAttackStyle?

    private var powerupElapseObserver: NSObjectProtocol?

    init(duration: CGFloat = StrengthPowerupEffect.DEFAULT_DURATION,
         factor: CGFloat = StrengthPowerupEffect.DEFAULT_FACTOR) {
        self.duration = duration
        self.factor = factor
        subscribeToEvents()
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
        allowPlayerToDestroyBlocks(player: collider, delegate: delegate, enable: true)
        guard let colliderPhysicsComponent = delegate.getComponent(of: PhysicsComponent.self, for: collider) else {
            return
        }
        let powerupElapseEvent = PowerupElapseEvent(powerup: self)
        let timerComponent = TimerComponent(entity: collider, duration: StrengthPowerupEffect.DEFAULT_DURATION, event: powerupElapseEvent)
        delegate.addComponent(timerComponent, to: collider)
        EventManager.shared.postEvent(PowerupActivateEvent(type: .strength,
                                                           name: "Strength 💪",
                                                           position: colliderPhysicsComponent.physicsBody.position))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }

    private func allowPlayerToDestroyBlocks(player: Entity, delegate: CollisionEffectDelegate, enable: Bool) {
        guard let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: player) else {
            return
        }
        guard let headAttackStyle = attackableComponent.getAttackStyle(with: HeadAttackStyle.self) else {
            return
        }
        headAttackStyleAffected = headAttackStyle
        headAttackStyle.damage = StrengthPowerupEffect.HEAD_STRENGTH_DAMAGE
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        guard let powerupElapseEvent = event as? PowerupElapseEvent else {
            return
        }
        powerupElapseEvent.powerup.restore()
    }

    func restore() {
        headAttackStyleAffected?.damage = .zero
    }
}
