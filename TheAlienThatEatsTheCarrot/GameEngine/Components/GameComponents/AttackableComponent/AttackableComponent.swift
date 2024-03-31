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
    var targetables: [Component.Type]
    var attackStyle: AttackStyle

    init(entity: Entity, damage: CGFloat = AttackableComponent.DEFAULT_DAMAGE, targetables: [Component.Type],
         attackStyle: AttackStyle = MeleeAttackStyle()) {
        self.entity = entity
        self.damage = damage
        self.targetables = targetables
        self.attackStyle = attackStyle
    }

    func attackIfPossible(attackee: Entity, delegate: AttackableDelegate) {
        attackStyle.attack(damage: damage, attacker: entity, attackee: attackee,
                           targetables: targetables, delegate: delegate)
    }
}
