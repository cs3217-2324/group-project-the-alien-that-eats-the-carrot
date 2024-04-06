//
//  LiveDecreaseEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

struct LiveDecreaseEvent: Event {
    static var name: Notification.Name = .liveDecrease
    let entity: Entity
}

extension Notification.Name {
    static let liveDecrease = Notification.Name("liveDecrease")
}
