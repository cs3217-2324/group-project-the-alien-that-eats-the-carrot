//
//  AttackableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class AttackableComponent: Component {
    static let DEFAULT_DAMAGE = 10.0
    var entity: Entity
    var damage: CGFloat
    var targetables: [Component.Type]
    var attackStyle: AttackStyle

    init(entity: Entity, targetables: [Component.Type], damage: CGFloat = AttackableComponent.DEFAULT_DAMAGE,
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
