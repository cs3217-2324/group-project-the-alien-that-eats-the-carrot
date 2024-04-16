//
//  PowerupActivateEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 16/4/24.
//

import Foundation

struct PowerupActivateEvent: Event {
    static var name: Notification.Name = .powerupActivate
    let type: PowerupType
    let name: String
}

extension Notification.Name {
    static let powerupActivate = Notification.Name("powerupActivate")
}
