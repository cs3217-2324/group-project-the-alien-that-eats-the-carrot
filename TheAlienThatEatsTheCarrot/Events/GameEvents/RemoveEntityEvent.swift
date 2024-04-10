//
//  RemoveEntityEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

struct RemoveEntityEvent: Event {
    static var name: Notification.Name = .removeEntity
    let entity: Entity
}

extension Notification.Name {
    static let removeEntity = Notification.Name("removeEntity")
}
