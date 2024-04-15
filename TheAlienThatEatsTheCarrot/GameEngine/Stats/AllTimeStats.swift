//
//  AllTimeStats.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/4/24.
//

import Foundation

/**
 Manages the All-Time statistics of the game, i.e. the cumulative stats across all games.
 */
class AllTimeStats {
    static let shared = AllTimeStats()
    private let defaults: UserDefaults
    var totalScore: Int {
        defaults.integer(forKey: .totalScore)
    }
    var totalGamesPlayed: Int {
        defaults.integer(forKey: .totalGamesPlayed)
    }
    var totalEnemiesKilled: Int {
        defaults.integer(forKey: .totalEnemiesKilled)
    }
    var normalHighestScore: Int {
        defaults.integer(forKey: .normalHighestScore)
    }

    private init() {
        defaults = UserDefaults.standard
        registerAllTimeStats()
    }

    private func registerAllTimeStats() {
        defaults.register(defaults: [.totalScore: Int.zero,
                                     .totalGamesPlayed: Int.zero,
                                     .totalEnemiesKilled: Int.zero,
                                     .normalHighestScore: Int.zero])
    }

    /// Update all-time stats once a game ends
    ///
    /// - Parameters:
    ///   - gameStats: stats from the latest game
    ///   - gameMode: game mode of the latest game
    func addStatsFromLatestGame(_ gameStats: GameStats, _ gameMode: GameMode) {
        updateCumulativeStats(gameStats)
        updateHighScores(gameStats, gameMode)
    }

    private func updateCumulativeStats(_ gameStats: GameStats) {
        defaults.setValue(totalGamesPlayed + 1,
                          forKey: .totalGamesPlayed)
        defaults.setValue(totalScore + gameStats.score,
                          forKey: .totalScore)
        defaults.setValue(totalEnemiesKilled + gameStats.enemiesKilled, forKey: .totalEnemiesKilled)
    }

    private func updateHighScores(_ gameStats: GameStats, _ gameMode: GameMode) {
        switch gameMode {
        case .normal:
            defaults.setValue(max(normalHighestScore, gameStats.score), forKey: .normalHighestScore)
        }
    }

    func getHighScore(for gameMode: GameMode) -> String {
        switch gameMode {
        case .normal:
            return String(self.normalHighestScore)
        }
    }
}
