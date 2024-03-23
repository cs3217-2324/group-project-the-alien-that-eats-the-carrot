//
//  GameStateComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class GameStateComponent: Component {
    var entity: Entity
    var gameState: GameState
    
    init(entity: Entity, gameState: GameState = .ongoing) {
        self.entity = entity
        self.gameState = gameState
    }
}

enum GameState {
    case ongoing, pause, gameOver
}
