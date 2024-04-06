//
//  GameSettings.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

protocol GameSettings {
    var spawnPoint: CGPoint { get set }
}

class NormalGameSettings: GameSettings {
    var spawnPoint: CGPoint = CGPoint(x: 200.0, y: 200.0)
}
