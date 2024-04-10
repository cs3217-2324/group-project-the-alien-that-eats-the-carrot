//
//  AttackCoolDownEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 5/4/24.
//

import Foundation

class AttackCoolDownEvent: Event {
    static var name: Notification.Name = .attackCoolDown
    var attackStyle: HasCoolDown

    init(attackStyle: HasCoolDown) {
        self.attackStyle = attackStyle
    }
}

extension Notification.Name {
    static let attackCoolDown = Notification.Name("attackCoolDown")
}
