//
//  AttackableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class AttackableComponent: Component {
    static var DEFAULT_DAMAGE = 100.0
    var entity: Entity
    var damage: CGFloat
    
    init(entity: Entity, damage: CGFloat = AttackableComponent.DEFAULT_DAMAGE) {
        self.entity = entity
        self.damage = damage
    }
}
