//
//  AllTimeAchievementGroup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/4/24.
//

import Foundation

class AllTimeAchievementGroup: AchievementGroup {
    weak var achievementManagerDelegate: AchievementManagerDelegate?
    var achievementTiers: [Achievement]
    private var scoreChangeObserver: NSObjectProtocol?

    init() {
        self.achievementTiers = [
            TotalScore(criterion: 100)
        ]
    }

    deinit {
        if let observer1 = scoreChangeObserver {
            EventManager.shared.unsubscribe(from: observer1)
        }
    }

    func subscribeToEvents() {
        scoreChangeObserver = EventManager.shared.subscribe(to: ScoreUpdateEvent.self, using: onScoreChangeUpdate)
    }

    private lazy var onScoreChangeUpdate = { [weak self] (_ event: Event) -> Void in
        guard let self = self,
              let scoreUpdateEvent = event as? ScoreUpdateEvent else {
            return
        }
        self.checkIfCompleted(gameStats: scoreUpdateEvent.gameStats)
    }
}

extension AllTimeAchievementGroup {
    class TotalScore: Achievement {
        var name: String {
            "Earn \(criterion) points across all games"
        }
        var isCompleted = false
        let isRepeatable = false
        let criterion: Int

        init(criterion: Int) {
            self.criterion = criterion
        }

        func checkIfCompleted(gameStats: GameStats?) -> Bool {
            if !isCompleted && AllTimeStats.shared.totalScore >= criterion {
                isCompleted = true
                return true
            }
            return false
        }
    }
}
