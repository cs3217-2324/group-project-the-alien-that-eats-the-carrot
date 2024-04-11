//
//  RemoveSelfInDurationEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class RemoveSelfInDurationEffect: CollisionEffect {
    let duration: CGFloat

    init(duration: CGFloat) {
        self.duration = duration
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        let removeSelfEvent = RemoveEntityEvent(entity: collidee)
        let timerComponent = TimerComponent(entity: collidee, duration: duration, event: removeSelfEvent)
        delegate.addComponent(timerComponent, to: collidee)
    }
}
