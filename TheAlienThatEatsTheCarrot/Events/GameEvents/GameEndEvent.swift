//
//  GameEndEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 14/4/24.
//

import Foundation

struct GameEndEvent: Event {
    static var name: Notification.Name = .gameEnd
    var isWin: Bool
}

extension Notification.Name {
    static let gameEnd = Notification.Name("gameEnd")
}
