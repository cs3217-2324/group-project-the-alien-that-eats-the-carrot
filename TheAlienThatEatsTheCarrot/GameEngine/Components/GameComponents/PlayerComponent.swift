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
}
