//
//  CompleteGameEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 15/4/24.
//

class characterHitExitBlockEffect: CollisionEffect {
    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        EventManager.shared.postEvent(CharacterHitExitBlockEvent())
    }
}
