//
//  DestroyableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

class DestroyableComponent: Component {
    static let DEFAULT_DESTROYABLE_HEALTH = 100.0
    var entity: Entity
    var health: CGFloat
    var isDestroyed: Bool
    var isInvinsible: Bool

    init(entity: Entity, health: CGFloat = DestroyableComponent.DEFAULT_DESTROYABLE_HEALTH,
         isDestroyed: Bool = false, isInvinsible: Bool = false) {
        self.entity = entity
        self.health = health
        self.isDestroyed = isDestroyed
        self.isInvinsible = isInvinsible
    }

    func takeDamage(_ damage: CGFloat) {
        health -= damage
        if health <= 0 {
            isDestroyed = true
        }
    }
}
