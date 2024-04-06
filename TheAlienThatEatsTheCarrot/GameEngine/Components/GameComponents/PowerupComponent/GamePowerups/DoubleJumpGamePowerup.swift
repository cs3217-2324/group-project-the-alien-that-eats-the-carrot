//
//  DoubleJumpGamePowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class DoubleJumpGamePowerup: GamePowerup {
    static let DEFAULT_DURATION = 10.0
    var duration: CGFloat
    var defaultMaxJump = 1

    var restoreAction: (() -> Void)?

    init(duration: CGFloat = DoubleJumpGamePowerup.DEFAULT_DURATION) {
        self.duration = duration
    }

    func effectToEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
        guard let jumpStateComponent = delegate.getComponent(of: JumpStateComponent.self, for: entity) else {
            return
        }
        defaultMaxJump = jumpStateComponent.maxJump
        jumpStateComponent.maxJump *= 2

        let eventWhenPowerupElapse = PowerupElapseEvent(powerup: self)
        let timerComponent = TimerComponent(entity: entity, duration: duration, event: eventWhenPowerupElapse)
        delegate.addComponent(timerComponent, to: entity)

        self.restoreAction = { [weak self, weak entity] in
            guard let strongSelf = self, let entity = entity,
                  let jumpStateComponent = delegate.getComponent(of: JumpStateComponent.self, for: entity) else {
                return
            }
            jumpStateComponent.maxJump = strongSelf.defaultMaxJump
        }
    }

    func restoreDefault() {
        self.restoreAction?()
    }
}
