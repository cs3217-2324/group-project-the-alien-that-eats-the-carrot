//
//  MeleeAttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class MeleeAttackStyle: AttackStyle {
    static let DEFAULT_DAMAGE = 50.0
    var damage: CGFloat

    init(damage: CGFloat = MeleeAttackStyle.DEFAULT_DAMAGE) {
        self.damage = damage
    }

    func attack(attacker: Entity, attackee: Entity, delegate: AttackableDelegate) {
        guard
            let attackerRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: attacker),
            let attackeeRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: attackee) else {
            return
        }
        if attackerRenderableComponent.overlapsWith(attackeeRenderableComponent) {
            dealDamage(damage, to: attackee, delegate: delegate)
        }
    }

    private func dealDamage(_ damage: CGFloat, to entity: Entity, delegate: AttackableDelegate) {
        guard let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: entity) else {
            return
        }
        destroyableComponent.takeDamage(damage)
    }
}
