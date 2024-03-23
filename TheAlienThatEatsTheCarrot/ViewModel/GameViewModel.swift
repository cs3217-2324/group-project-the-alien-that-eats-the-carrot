//
//  GameViewModel.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

class GameViewModel: ObservableObject {
    let gameEngine: GameEngine
    let gameLoop: GameLoop
    let gameRenderer: GameRenderer

    var gameMode: GameMode

    var renderableComponentsA: [RenderableComponent]
    var renderableComponentsB: [RenderableComponent]

    init(gameMode: GameMode = .singlePlayer) {
        self.gameMode = gameMode
        self.gameEngine = GameEngine()
        self.gameLoop = GameLoop(gameEngine: gameEngine)
        self.gameRenderer = GameRenderer(gameMode: gameMode)
        self.renderableComponentsA = []
        self.renderableComponentsB = []
    }

    func start() {
        gameLoop.start()
    }
}

enum GameMode {
    case singlePlayer, doublePlayer
}
