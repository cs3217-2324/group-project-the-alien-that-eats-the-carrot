//
//  EnemyKilledEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 11/4/24.
//

import Foundation

struct EnemyKilledEvent: Event {
    static var name: Notification.Name = .enemyKilled
    var entity: Entity
}

extension Notification.Name {
    static let enemyKilled = Notification.Name("enemyKilled")
}
