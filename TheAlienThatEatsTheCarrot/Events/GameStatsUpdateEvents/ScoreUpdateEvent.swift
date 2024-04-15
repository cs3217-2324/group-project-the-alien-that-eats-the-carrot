//
//  ScoreUpdateEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/4/24.
//

import Foundation

class ScoreUpdateEvent: Event {
    static var name: Notification.Name = .scoreUpdate
    let gameStats: GameStats

    init(gameStats: GameStats) {
        self.gameStats = gameStats
    }
}

extension Notification.Name {
    static let scoreUpdate = Notification.Name("scoreUpdate")
}
