//
//  ActivatePowerupEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

protocol ActivatePowerupEffect: CollisionEffect {
    var duration: CGFloat { get }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate)

    func restore()
}
