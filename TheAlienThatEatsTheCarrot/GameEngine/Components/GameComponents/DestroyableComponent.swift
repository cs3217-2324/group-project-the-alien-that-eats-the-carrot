//
//  DestroyableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

class DestroyableComponent: Component {
    static let DEFAULT_DESTROYABLE_HEALTH = 100
    var entity: Entity
    var health: Int
    var isDestroyed: Bool

    init(entity: Entity, health: Int = DestroyableComponent.DEFAULT_DESTROYABLE_HEALTH, isDestroyed: Bool = false) {
        self.entity = entity
        self.health = health
        self.isDestroyed = isDestroyed
    }
}
