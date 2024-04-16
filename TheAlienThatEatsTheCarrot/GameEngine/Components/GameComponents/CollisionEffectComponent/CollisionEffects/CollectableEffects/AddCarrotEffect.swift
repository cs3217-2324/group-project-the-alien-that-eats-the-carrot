//
//  AddCarrotEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class AddCarrotEffect: CollisionEffect {
    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        EventManager.shared.postEvent(CarrotCollectedEvent(entity: collidee))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }
}
