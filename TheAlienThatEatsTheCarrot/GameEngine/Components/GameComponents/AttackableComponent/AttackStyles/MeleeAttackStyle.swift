//
//  MeleeAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class MeleeAttackStyle: AttackStyle {
    func attack(damage: CGFloat, attacker: Entity, attackee: Entity,
                targetables: [Component.Type], delegate: AttackableDelegate) {
        guard
            let attackerRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: attacker),
            let attackeeRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: attackee) else {
            return
        }
        if attacker != attackee
            && canAttack(attackee, with: targetables, using: delegate)
            && attackerRenderableComponent.overlapsWith(attackeeRenderableComponent) {
            dealDamage(damage, to: attackee, delegate: delegate)
        }
    }
}
