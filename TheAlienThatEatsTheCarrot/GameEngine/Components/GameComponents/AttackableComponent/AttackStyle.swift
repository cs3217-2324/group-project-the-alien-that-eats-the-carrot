//
//  AttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol AttackStyle {
    var targetables: [Component.Type] { get set }
    var damage: CGFloat { get set }
    func attack(attacker: Entity, attackee: Entity,
                delegate: AttackableDelegate)

    func canAttack(_ attackee: Entity, with targetables: [Component.Type], using delegate: AttackableDelegate) -> Bool
    func dealDamage(_ damage: CGFloat, to entity: Entity, delegate: AttackableDelegate)
}

extension AttackStyle {
    func canAttack(_ attackee: Entity, with targetables: [Component.Type], using delegate: AttackableDelegate) -> Bool {
        targetables.contains { targetable in
            delegate.getComponent(of: targetable, for: attackee) != nil
        }
    }

    func dealDamage(_ damage: CGFloat, to entity: Entity, delegate: AttackableDelegate) {
        guard let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: entity) else {
            return
        }
        destroyableComponent.takeDamage(damage, delegate: delegate)
        if destroyableComponent.isDestroyed {
            removeRelevantComponentsForDestroyedEntity(destroyableComponent.entity, delegate: delegate)
        }
    }

    private func removeRelevantComponentsForDestroyedEntity(_ entity: Entity, delegate: AttackableDelegate) {
        if let renderableComponent = delegate.getComponent(of: RenderableComponent.self, for: entity) {
            delegate.removeComponent(renderableComponent, from: entity)
        }
        let removeEntityEvent = RemoveEntityEvent(entity: entity)
        let timerComponent = TimerComponent(entity: entity, duration: 0.1, event: removeEntityEvent)
        delegate.addComponent(timerComponent, to: entity)
    }
}
