//
//  DamageEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

struct DamageEvent: Event {
    static var name: Notification.Name = .damage
    let position: CGPoint
    let damage: CGFloat
}

extension Notification.Name {
    static let damage = Notification.Name("damage")
}
