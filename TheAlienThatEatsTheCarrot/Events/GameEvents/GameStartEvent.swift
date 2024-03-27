//
//  GameStartEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 27/3/24.
//

import Foundation

struct GameStartEvent: Event {
    static var name: Notification.Name = .gameStart
}

extension Notification.Name {
    static let gameStart = Notification.Name("gameStart")
}
