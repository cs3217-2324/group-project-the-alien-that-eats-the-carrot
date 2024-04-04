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

    static let DEFAULT_LEFT_VELOCITY = CGVector(dx: -100.0, dy: 0)
    static let DEFAULT_RIGHT_VELOCITY = CGVector(dx: 100.0, dy: 0)
    static let DEFAULT_JUMP_FORCE = CGVector(dx: 0, dy: -200000.0)
}
