//
//  DestroyableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

class DestroyableComponent: Component {
    var entity: Entity
    var health: Int
    var isDestroyed: Bool
    
    init(entity: Entity, health: Int, isDestroyed: Bool) {
        self.entity = entity
        self.health = health
        self.isDestroyed = isDestroyed
    }
}
