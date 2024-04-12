//
//  GameStats.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class GameStats {
    let coins: [Int]
    let carrots: [Int]
    let scores: [CGFloat]
    var lives: [Int]
    weak var nexus: Nexus?

    private(set) var enemiesKilled: Int = .zero {
        didSet {
            EventManager.shared.postEvent(EnemiesKilledStatUpdateEvent(gameStats: self))
        }
    }
    private var powerupUsedObserver: NSObjectProtocol?
    private var enemiesKilledObserver: NSObjectProtocol?
    private var blockBrokenObserver: NSObjectProtocol?
    private var scoreChangeObserver: NSObjectProtocol?

    init(nexus: Nexus,
         coins: [Int] = [],
         carrots: [Int] = [],
         scores: [CGFloat] = [],
         lives: [Int] = [],
         enemiesKilled: Int = .zero) {
        self.nexus = nexus
        self.coins = coins
        self.carrots = carrots
        self.scores = scores
        self.lives = lives
        self.enemiesKilled = enemiesKilled
    }

    private func observePublishers() {
        
    }

    private lazy var onStatEventRef = { [weak self] (event: Event) -> Void in
        self?.onStatEvent(event)
    }

    /// Update game stats based on the received event
    ///
    /// - Parameters:
    ///   - event: event received
    private func onStatEvent(_ event: Event) {
        switch event {
        default:
            return
        }
    }

    func getLatestGameStats() -> GameStats? {
        guard let playerComponents = self.nexus?.getComponents(of: PlayerComponent.self) else {
            return nil
        }
        var livesArr: [Int] = []
        for playerComponent in playerComponents {
            guard let destroyableComponnet = nexus?.getComponent(of: DestroyableComponent.self, for: playerComponent.entity) else {
                continue
            }
            let lives = destroyableComponnet.lives
            livesArr.append(lives)
        }
        self.lives = livesArr
        return self
    }
}
