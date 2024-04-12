//
//  GameStats.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class GameStats {
    var coins: Int
    var carrots: Int
    var scores: CGFloat
    var lives: [Int]
    weak var nexus: Nexus?

    private(set) var enemiesKilled: Int = .zero {
        didSet {
            EventManager.shared.postEvent(EnemiesKilledStatUpdateEvent(gameStats: self))
        }
    }
    private var carrotCollectedObsever: NSObjectProtocol?
    private var coinCollectedObserver: NSObjectProtocol?
    private var enemiesKilledObserver: NSObjectProtocol?

    init(nexus: Nexus,
         coins: Int = 0,
         carrots: Int = 0,
         scores: CGFloat = 0,
         lives: [Int] = [],
         enemiesKilled: Int = .zero) {
        self.nexus = nexus
        self.coins = coins
        self.carrots = carrots
        self.scores = scores
        self.lives = lives
        self.enemiesKilled = enemiesKilled
        observePublishers()
    }

    private func observePublishers() {
        carrotCollectedObsever = EventManager.shared.subscribe(to: CarrotCollectedEvent.self, using: onStatEventRef)
        coinCollectedObserver = EventManager.shared.subscribe(to: CoinCollectedEvent.self, using: onStatEventRef)
        enemiesKilledObserver = EventManager.shared.subscribe(to: EnemyKilledEvent.self, using: onStatEventRef)
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
        case _ as CarrotCollectedEvent:
            self.carrots += 1
        case _ as CoinCollectedEvent:
            self.coins += 1
        case _ as EnemyKilledEvent:
            self.enemiesKilled += 1
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
