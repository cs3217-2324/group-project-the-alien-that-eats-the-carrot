//
//  PostEventEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class PostEventEffect: CollisionEffect {
    let eventToPost: Event

    init(eventToPost: Event) {
        self.eventToPost = eventToPost
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        EventManager.shared.postEvent(eventToPost)
    }
}
