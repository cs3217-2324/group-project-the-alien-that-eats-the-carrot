//
//  JumpStateComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class JumpStateComponent: Component {
    static let DEFAULT_MAX_JUMP = 1
    var entity: Entity
    var canJump: Bool = true
    var maxJump: Int
    var remainingJump: Int

    init(entity: Entity, maxJump: Int = JumpStateComponent.DEFAULT_MAX_JUMP,
         remainingJump: Int = JumpStateComponent.DEFAULT_MAX_JUMP) {
        self.entity = entity
        self.maxJump = maxJump
        self.remainingJump = remainingJump
    }
}
