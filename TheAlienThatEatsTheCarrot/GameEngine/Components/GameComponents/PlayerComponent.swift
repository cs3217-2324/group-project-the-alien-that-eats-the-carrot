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

    init(entity: Entity, action: ControlAction = .idle) {
        self.entity = entity
        self.action = action
    }
}

enum ControlAction {
    case idle, jump, left, right
}
