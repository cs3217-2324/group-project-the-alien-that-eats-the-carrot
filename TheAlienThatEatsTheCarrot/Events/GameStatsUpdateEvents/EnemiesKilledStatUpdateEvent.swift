//
//  EnemiesKilledStatUpdateEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 11/4/24.
//

import Foundation

class EnemiesKilledStatUpdateEvent: Event {
    static var name: Notification.Name = .enemiesKilledStatusUpdate
    let gameStats: GameStats

    init(gameStats: GameStats) {
        self.gameStats = gameStats
    }
}

extension Notification.Name {
    static let enemiesKilledStatusUpdate = Notification.Name("enemiesKilledStatusUpdate")
}
