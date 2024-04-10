//
//  AttackableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class AttackableComponent: Component {
    var entity: Entity
    var attackStyles: [any AttackStyle]

    init(entity: Entity,
         attackStyles: [any AttackStyle]) {
        self.entity = entity
        self.attackStyles = attackStyles
    }

    func attackIfPossible(attackee: Entity, delegate: AttackableDelegate) {
        for attackStyle in attackStyles {
            attackStyle.attack(attacker: entity, attackee: attackee, delegate: delegate)
        }
    }

    func getAttackStyle<T: AttackStyle>(with type: T.Type) -> T? {
        for attackStyle in attackStyles {
            if let specificAttackStyle = attackStyle as? T {
                return specificAttackStyle
            }
        }
        return nil
    }
}
