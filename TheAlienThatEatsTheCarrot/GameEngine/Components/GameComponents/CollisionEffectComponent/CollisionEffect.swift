//
//  CollisionEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

protocol CollisionEffect {
    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate)
}
