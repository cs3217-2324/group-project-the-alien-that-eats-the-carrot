//
//  CoinCollectedEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/4/24.
//

import Foundation

struct CoinCollectedEvent: Event {
    static var name: Notification.Name = .coinCollected
    var entity: Entity
    var value: Int
}

extension Notification.Name {
    static let coinCollected = Notification.Name("coinCollected")
}
