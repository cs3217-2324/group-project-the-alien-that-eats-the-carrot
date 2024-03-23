//
//  GameViewModel.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

class GameViewModel: ObservableObject {
    let gameEngine = GameEngine()
    let gameLoop = GameLoop()

    init() {
        gameLoop.gameEngine = gameEngine
    }

    func start() {
        gameLoop.start()
    }
}
