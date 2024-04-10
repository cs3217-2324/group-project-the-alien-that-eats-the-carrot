//
//  HasCoolDown.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

protocol HasCoolDown: AnyObject {
    var coolDownDuration: CGFloat { get set }
    var isCoolingDown: Bool { get set }

    func setCoolDown(for entity: Entity, delegate: AttackableDelegate)
}

extension HasCoolDown {
    func setCoolDown(for entity: Entity, delegate: AttackableDelegate) {
        self.isCoolingDown = true
        let attackCooldownEvent = AttackCoolDownEvent(attackStyle: self)
        let timerComponent = TimerComponent(entity: entity, duration: coolDownDuration, event: attackCooldownEvent)
        delegate.addComponent(timerComponent, to: entity)
    }
}
