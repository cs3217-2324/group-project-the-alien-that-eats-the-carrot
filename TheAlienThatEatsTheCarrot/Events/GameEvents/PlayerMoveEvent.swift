//
//  PlayerMoveEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 27/3/24.
//

import Foundation

struct PlayerMoveEvent: Event {
    static var name: Notification.Name = .playerMove
    var action: ControlAction
    var playerRole: PlayerRole

    init(action: ControlAction, player: PlayerRole = .one) {
        self.action = action
        self.playerRole = player
    }
}

extension Notification.Name {
    static let playerMove = Notification.Name("playerMove")
}
