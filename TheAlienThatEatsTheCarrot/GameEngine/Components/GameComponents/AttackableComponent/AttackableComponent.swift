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
    var attackStyles: [any AttackStyle]

    init(entity: Entity, damage: CGFloat = AttackableComponent.DEFAULT_DAMAGE,
         attackStyles: [any AttackStyle]) {
        self.entity = entity
        self.damage = damage
        self.attackStyles = attackStyles
    }

    func attackIfPossible(attackee: Entity, delegate: AttackableDelegate) {
        for attackStyle in attackStyles {
            attackStyle.attack(damage: damage, attacker: entity, attackee: attackee,
                               delegate: delegate)
        }
    }
}
