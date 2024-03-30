//
//  MeleeAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class MeleeAttackStyle: AttackStyle {
    func attack(attacker: Entity, attackee: Entity, delegate: AttackableDelegate) {
        guard
            let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: attacker),
            let attackerRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: attacker),
            let attackeeRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: attackee) else {
            return
        }
        if attackerRenderableComponent.overlapsWith(attackeeRenderableComponent) {
            dealDamage(attackableComponent.damage, to: attackee, delegate: delegate)
        }
    }

    private func dealDamage(_ damage: CGFloat, to entity: Entity, delegate: AttackableDelegate) {
        guard let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: entity) else {
            return
        }
        destroyableComponent.takeDamage(damage)
    }
}
