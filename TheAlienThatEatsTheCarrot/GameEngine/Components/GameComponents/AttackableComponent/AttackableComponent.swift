//
//  AttackableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class AttackableComponent: Component {
    static let DEFAULT_DAMAGE = 50.0
    var entity: Entity
    var damage: CGFloat
    var attackStyle: AttackStyle

    init(entity: Entity, damage: CGFloat = AttackableComponent.DEFAULT_DAMAGE,
         attackStyle: AttackStyle = MeleeAttackStyle()) {
        self.entity = entity
        self.damage = damage
        self.attackStyle = attackStyle
    }

    func attackIfPossible(attackee: Entity, delegate: AttackableDelegate) {
        attackStyle.attack(attacker: entity, attackee: attackee, delegate: delegate)
    }
}
