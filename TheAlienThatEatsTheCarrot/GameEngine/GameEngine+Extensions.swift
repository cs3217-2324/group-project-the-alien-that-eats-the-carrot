//
//  GameEngine+Extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

extension GameEngine {
    func createGameStatsFromECS() -> GameStats {
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        var livesArr: [Int] = []
        var coinsArr: [Int] = []
        var carrotsArr: [Int] = []
        var scoresArr: [CGFloat] = []
        for playerComponent in playerComponents {
            guard
                let destroyableComponent = nexus.getComponent(of: DestroyableComponent.self, for: playerComponent.entity),
                let inventoryComponent = nexus.getComponent(of: InventoryComponent.self, for: playerComponent.entity) else {
                continue
            }
            let lives = destroyableComponent.lives
            let coins = inventoryComponent.coinCount
            let carrots = inventoryComponent.carrotCount
            livesArr.append(lives)
            coinsArr.append(coins)
            carrotsArr.append(carrots)
        }
        print("Coins \(coinsArr), Carrots: \(carrotsArr), Lives: \(livesArr)")
        let gameStats = GameStats(coins: coinsArr, carrots: carrotsArr,
                                  scores: scoresArr, lives: livesArr)
        return gameStats
    }
}
