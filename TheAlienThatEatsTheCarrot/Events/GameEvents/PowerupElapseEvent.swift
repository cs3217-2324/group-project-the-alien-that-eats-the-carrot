//
//  PowerupElapseEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class PowerupElapseEvent: Event {
    static var name: Notification.Name = .powerupElapse
    let powerup: GamePowerup

    init(powerup: GamePowerup) {
        self.powerup = powerup
    }
}

extension Notification.Name {
    static let powerupElapse = Notification.Name("powerupElapse")
}
