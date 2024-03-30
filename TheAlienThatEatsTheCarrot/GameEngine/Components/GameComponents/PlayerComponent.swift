//
//  PlayerComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class PlayerComponent: Component {
    static let DEFAULT_JUMP_FACTOR = 1.0
    static let DEFAULT_SPEED_FACTOR = 1.0
    var entity: Entity
    var action: ControlAction
    var playerRole: PlayerRole

    var jumpFactor: CGFloat
    var speedFactor: CGFloat

    init(entity: Entity, action: ControlAction = .idle, playerRole: PlayerRole = .one,
         jumpFactor: CGFloat = PlayerComponent.DEFAULT_JUMP_FACTOR,
         speedFactor: CGFloat = PlayerComponent.DEFAULT_SPEED_FACTOR) {
        self.entity = entity
        self.action = action
        self.playerRole = playerRole
        self.jumpFactor = jumpFactor
        self.speedFactor = speedFactor
    }
}

enum ControlAction {
    case idle, jump, left, right
}
