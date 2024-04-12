//
//  AchievementManagementDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 11/4/24.
//

protocol AchievementManagerDelegate: AnyObject {
    func markAsCompleted(_ achievement: Achievement)
}
