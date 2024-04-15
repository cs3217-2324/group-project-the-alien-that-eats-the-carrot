//
//  CarrotPickedUpEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/4/24.
//

import Foundation

struct CarrotCollectedEvent: Event {
    static var name: Notification.Name = .carrotCollected
    var entity: Entity
}

extension Notification.Name {
    static let carrotCollected = Notification.Name("carrotCollected")
}
