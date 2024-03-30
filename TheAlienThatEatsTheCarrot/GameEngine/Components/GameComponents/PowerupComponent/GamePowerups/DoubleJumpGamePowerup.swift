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

    var restoreAction: (() -> Void)?

    init(duration: CGFloat = DoubleJumpGamePowerup.DEFAULT_DURATION) {
        self.duration = duration
    }

    func effectToEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
    }

    func restoreDefault() {
        self.restoreAction?()
    }
}
