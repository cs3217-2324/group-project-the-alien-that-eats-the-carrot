//
//  PlayerDiedEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

struct PlayerDiedEvent: Event {
    static var name: Notification.Name = .playerDied
}

extension Notification.Name {
    static let playerDied = Notification.Name("playerDied")
}
