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

    init(coins: [Int], carrots: [Int], scores: [CGFloat], lives: [Int]) {
        self.coins = coins
        self.carrots = carrots
        self.scores = scores
        self.lives = lives
    }
}
