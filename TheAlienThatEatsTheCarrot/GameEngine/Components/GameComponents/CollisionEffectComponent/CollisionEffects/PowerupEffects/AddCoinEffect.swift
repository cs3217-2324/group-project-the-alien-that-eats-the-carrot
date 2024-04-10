//
//  AddCoinEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class AddCoinEffect: CollisionEffect {
    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard let inventoryComponent = delegate.getComponent(of: InventoryComponent.self, for: collider) else {
            return
        }
        inventoryComponent.coinCount += 1
        EventManager.shared.postEvent(RemoveEntityEvent(entity: collidee))
    }
}
