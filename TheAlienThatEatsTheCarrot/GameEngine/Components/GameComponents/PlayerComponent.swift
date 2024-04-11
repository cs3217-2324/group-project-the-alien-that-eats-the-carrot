//
//  PlayerComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class PlayerComponent: Component {
    var entity: Entity
    var action: ControlAction
    var playerRole: PlayerRole

    init(entity: Entity, action: ControlAction = .idle, playerRole: PlayerRole = .one) {
        self.entity = entity
        self.action = action
        self.playerRole = playerRole
    }
}

enum ControlAction {
    case idle, jump, left, right

    static let DEFAULT_LEFT_FORCE = CGVector(dx: -1_000.0, dy: 0)
    static let DEFAULT_RIGHT_FORCE = CGVector(dx: 1_000.0, dy: 0)
    static let DEFAULT_JUMP_FORCE = CGVector(dx: 0, dy: -30_000.0)
    static let DEFAULT_DECELERATION_FORCE_MAGNITUDE = 1_000.0
}
