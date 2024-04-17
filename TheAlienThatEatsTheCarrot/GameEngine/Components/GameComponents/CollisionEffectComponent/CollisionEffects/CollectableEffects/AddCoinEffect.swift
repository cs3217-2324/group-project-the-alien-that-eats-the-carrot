//
//  AddCoinEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class AddCoinEffect: CollisionEffect {
    let value: Int

    init(value: Int) {
        self.value = value
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        EventManager.shared.postEvent(CoinCollectedEvent(entity: collidee, value: value))
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }
}
