//
//  MeleeFinishCooldownEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 5/4/24.
//

import Foundation

class MeleeFinishCooldownEvent: Event {
    static var name: Notification.Name = .meleeFinishCooldown
    let meleeAttackStyle: MeleeAttackStyle

    init(meleeAttackStyle: MeleeAttackStyle) {
        self.meleeAttackStyle = meleeAttackStyle
    }
}

extension Notification.Name {
    static let meleeFinishCooldown = Notification.Name("meleeFinishCooldown")
}
