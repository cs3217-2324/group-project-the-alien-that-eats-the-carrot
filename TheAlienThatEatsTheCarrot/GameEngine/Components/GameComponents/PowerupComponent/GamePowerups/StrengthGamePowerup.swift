//
//  StrengthGamePowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class StrengthGamePowerup: GamePowerup {
    static let DEFAULT_FACTOR = 3.0
    static let DEFAULT_DURATION = 10.0
    static let DEFAULT_DESTROYABLES: [ObjectType] = [.block(.normal)]

    let factor: CGFloat
    let duration: CGFloat
    let destroyables: [ObjectType]
    var defaultDamage: CGFloat = .zero

    var restoreAction: (() -> Void)?

    init(factor: CGFloat = StrengthGamePowerup.DEFAULT_FACTOR,
         destroyables: [ObjectType] = StrengthGamePowerup.DEFAULT_DESTROYABLES,
         duration: CGFloat = StrengthGamePowerup.DEFAULT_DURATION) {
        self.factor = factor
        self.destroyables = destroyables
        self.duration = duration
    }

    func effectToEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
        guard let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: entity) else {
            return
        }
        defaultDamage = attackableComponent.damage
        attackableComponent.damage *= factor
        changeBlockInvinsibility(to: false, delegate: delegate)
        let eventWhenPowerupElapse = PowerupElapseEvent(powerup: self)
        let timerComponent = TimerComponent(entity: entity, duration: duration, event: eventWhenPowerupElapse)
        delegate.addComponent(timerComponent, to: entity)

        self.restoreAction = { [weak self, weak entity] in
            guard let strongSelf = self, let entity = entity,
                  let attackableComponent = delegate.getComponent(of: AttackableComponent.self, for: entity) else {
                return
            }
            attackableComponent.damage = strongSelf.defaultDamage
            strongSelf.changeBlockInvinsibility(to: true, delegate: delegate)
        }
    }

    func restoreDefault() {
        self.restoreAction?()
    }

    private func changeBlockInvinsibility(to isInvinsible: Bool, delegate: PowerupActionDelegate) {
        let blockComponents = delegate.getComponents(of: BlockComponent.self)
        for blockComponent in blockComponents {
            guard
                let objectType = delegate.getComponent(of: RenderableComponent.self,
                                                       for: blockComponent.entity)?.objectType,
                let destroyableComponent = delegate.getComponent(of: DestroyableComponent.self, for: blockComponent.entity)
            else {
                return
            }
            if destroyables.contains(objectType) {
                destroyableComponent.isInvinsible = isInvinsible
            }
        }
    }
}
