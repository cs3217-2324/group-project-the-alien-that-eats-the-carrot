//
//  CreateNewEntityEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

struct CreatePowerupEvent: Event {
    static var name: Notification.Name = .createNewEntity
    let powerupType: PowerupType
    let position: CGPoint
}

extension Notification.Name {
    static let createNewEntity = Notification.Name("createNewEntity")
}
