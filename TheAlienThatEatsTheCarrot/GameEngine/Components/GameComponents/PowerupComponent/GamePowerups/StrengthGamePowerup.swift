//
//  StrengthGamePowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class StrengthGamePowerup: GamePowerup {
    static let DEFAULT_FACTOR = 3.0
    static let DEFAULT_DURATION = 10.0

    let factor: CGFloat
    let duration: CGFloat
    var defaultDamage: CGFloat = .zero

    var restoreAction: (() -> Void)?

    init(factor: CGFloat = StrengthGamePowerup.DEFAULT_FACTOR, duration: CGFloat = StrengthGamePowerup.DEFAULT_DURATION) {
        self.factor = factor
        self.duration = duration
    }

    func effectToEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
        guard let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: entity) else {
            return
        }
        defaultDamage = attackableComponent.damage
        attackableComponent.damage *= factor
        let eventWhenPowerupElapse = PowerupElapseEvent(powerup: self)
        let timerComponent = TimerComponent(entity: entity, duration: duration, event: eventWhenPowerupElapse)
        delegate.addComponent(timerComponent, to: entity)

        self.restoreAction = { [weak self, weak entity] in
            guard let strongSelf = self, let entity = entity,
                  let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: entity) else {
                return
            }
            attackableComponent.damage = strongSelf.defaultDamage
        }
    }

    func restoreDefault() {
        self.restoreAction?()
    }
}
