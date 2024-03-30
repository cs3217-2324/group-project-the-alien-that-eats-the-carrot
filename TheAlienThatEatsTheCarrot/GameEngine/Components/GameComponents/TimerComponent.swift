//
//  TimerComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class TimerComponent: Component {
    var entity: Entity
    var duration: CGFloat
    var timeElapsed: CGFloat = .zero
    var event: Event

    init(entity: Entity, duration: CGFloat, event: Event) {
        self.entity = entity
        self.duration = duration
        self.event = event
    }

    func updateTimeElapsed(deltaTime: CGFloat) {
        timeElapsed += deltaTime
    }
}
