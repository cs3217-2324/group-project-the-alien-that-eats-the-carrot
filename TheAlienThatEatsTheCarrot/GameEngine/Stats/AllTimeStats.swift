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

    private init() {
        defaults = UserDefaults.standard
        registerAllTimeStats()
    }

    private func registerAllTimeStats() {
        defaults.register(defaults: [:])
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

    }

    private func updateHighScores(_ gameStats: GameStats, _ gameMode: GameMode) {

    }

    func getHighScore(for gameMode: GameMode) -> String {
        ""
    }
}
