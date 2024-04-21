//
//  AchievementManager.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 11/4/24.
//

import Foundation

class AchievementManager: ObservableObject, AchievementManagerDelegate {
    @Published var newAchievement: Achievement?

    private let storage: UserDefaults
    private let achievementGroups: [AchievementGroup]

    init() {
        self.newAchievement = nil
        self.storage = UserDefaults.standard
        self.achievementGroups = [
            KillEnemyAchievementGroup(),
            AllTimeAchievementGroup()
        ]
        registerAchievementManagerDelegate()
        registerAchievements()
        setUpAchievementGroups()
    }

    func reinit() {
        self.newAchievement = nil
        resetAchievementGroups()
        setUpAchievementGroups()
    }

    func markAsCompleted(_ achievement: Achievement) {
        storage.set(true, forKey: achievement.name)
        newAchievement = achievement
    }

    private func resetAchievementGroups() {
        achievementGroups.forEach { achievementGroup in
            achievementGroup.reset()
        }
    }

    private func setUpAchievementGroups() {
        achievementGroups.forEach { achievementGroup in
            achievementGroup.subscribeToEvents()
            achievementGroup.markCompletedNonRepeatableEvents(storage: storage)
        }
    }

    private func registerAchievementManagerDelegate() {
        achievementGroups.forEach { achievementGroup in
            achievementGroup.achievementManagerDelegate = self
        }
    }

    private func registerAchievements() {
        achievementGroups.forEach { achievementGroup in
            achievementGroup.registerAchievements(storage: storage)
        }
    }
}
