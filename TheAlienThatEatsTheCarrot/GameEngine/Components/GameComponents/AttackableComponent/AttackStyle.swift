//
//  AttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol AttackStyle {
    func attack(damage: CGFloat, attacker: Entity, attackee: Entity,
                targetables: [Component.Type], delegate: AttackableDelegate)

    func canAttack(_ attackee: Entity, with targetables: [Component.Type], using delegate: AttackableDelegate) -> Bool
}

extension AttackStyle {
    func canAttack(_ attackee: Entity, with targetables: [Component.Type], using delegate: AttackableDelegate) -> Bool {
        return targetables.contains { targetable in
            delegate.getComponent(of: targetable, for: attackee) != nil
        }
    }
}
