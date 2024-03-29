//
//  InvinsibleGamePowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class InvinsibleGamePowerup: GamePowerup {
    static let DEFAULT_DURATION = 5.0
    var duration: CGFloat

    var restoreAction: (() -> Void)?

    init(duration: CGFloat = InvinsibleGamePowerup.DEFAULT_DURATION) {
        self.duration = duration
    }

    func effectToEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
        guard let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: entity) else {
            return
        }
        destroyableComponent.isInvinsible = true

        let eventWhenPowerupElapse = PowerupElapseEvent(powerup: self)
        let timerComponent = TimerComponent(entity: entity, duration: duration, event: eventWhenPowerupElapse)
        delegate.addComponent(timerComponent, to: entity)

        self.restoreAction = { [weak self, weak entity] in
            guard let strongSelf = self, let entity = entity,
                  let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: entity) else {
                return
            }
            destroyableComponent.isInvinsible = false
        }
    }

    func restoreDefault() {
        self.restoreAction?()
    }
}
