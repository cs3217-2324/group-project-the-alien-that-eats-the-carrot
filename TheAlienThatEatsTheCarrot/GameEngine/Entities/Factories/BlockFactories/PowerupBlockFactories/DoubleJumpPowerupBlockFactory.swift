//
//  DoubleJumpPowerupBlockFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class DoubleJumpPowerupBlockFactory: PowerupBlockFactory {
    override func createComponents() -> [Component] {
        var powerupBlockComponents = super.createComponents()
        let size = CGSize(width: boardObject.width, height: boardObject.height)
        let renderableComponent = RenderableComponent(entity: entity,
                                                      position: boardObject.position,
                                                      objectType: .block(.doubleJumpPowerup),
                                                      size: size)
        let collisionEffect = SpawnPowerupCollisionEffect(powerupType: .doubleJump, spawnDirection: .up)
        let collisionEffectComponent = CollisionEffectComponent(entity: entity,
                                                                acceptableComponentsColliders: [PlayerComponent.self],
                                                                acceptableDirectionsToCollideFrom: [.down],
                                                                collisionEffect: collisionEffect)
        let additionalComponents: [Component] = [renderableComponent, collisionEffectComponent]
        powerupBlockComponents.append(contentsOf: additionalComponents)
        return powerupBlockComponents
    }
}
