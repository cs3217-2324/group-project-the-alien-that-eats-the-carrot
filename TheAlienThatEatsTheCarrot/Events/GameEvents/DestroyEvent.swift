//
//  DestroyEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

struct DestroyEvent: Event {
    static var name: Notification.Name = .destroy
    let entity: Entity
}

extension Notification.Name {
    static let destroy = Notification.Name("destroy")
}
