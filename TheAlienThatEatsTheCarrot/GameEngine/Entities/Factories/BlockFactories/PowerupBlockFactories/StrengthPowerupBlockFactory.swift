//
//  StrengthPowerupBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class StrengthPowerupBlockFactory: PowerupBlockFactory {
    override func createComponents() -> [Component] {
        var powerupBlockComponents = super.createComponents()
        let collisionEffect = SpawnPowerupCollisionEffect(powerupType: .strength, spawnDirection: .up)
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.down],
                                                                collisionEffect: collisionEffect)
        powerupBlockComponents.append(collisionEffectComponent)
        return powerupBlockComponents
    }
}
