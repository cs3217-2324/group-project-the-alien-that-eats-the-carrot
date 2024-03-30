//
//  AttackableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class AttackableComponent: Component {
    var entity: Entity
    var attackStyle: AttackStyle

    init(entity: Entity, attackStyle: AttackStyle = MeleeAttackStyle()) {
        self.entity = entity
        self.attackStyle = attackStyle
    }
}
