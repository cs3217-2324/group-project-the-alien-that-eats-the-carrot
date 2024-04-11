//
//  GameStats.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

struct GameStats {
    let coins: [Int]
    let carrots: [Int]
    let scores: [CGFloat]
    let lives: [Int]

    private(set) var enemiesKilled: Int = .zero {
        didSet {
            EventManager.shared.postEvent(EnemiesKilledStatUpdateEvent(gameStats: self))
        }
    }
}
