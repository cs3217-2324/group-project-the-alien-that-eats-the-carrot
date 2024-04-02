//
//  PowerupElapseEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

struct PowerupElapseEvent: Event {
    static var name: Notification.Name = .powerupElapse
    let powerup: GamePowerup
}

extension Notification.Name {
    static let powerupElapse = Notification.Name("powerupElapse")
}
