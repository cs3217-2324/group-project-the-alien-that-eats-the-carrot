//
//  SpawnPowerupCollisionEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class SpawnPowerupCollisionEffect: CollisionEffect {
    static let DEFAULT_POSITION_OFFSET = 3.0
    static let DEFAULT_SPAWN_DIRECTION = Direction.up
    let powerupType: PowerupType
    let positionOffset: CGFloat
    let spawnDirection: Direction

    init(powerupType: PowerupType,
         spawnDirection: Direction = SpawnPowerupCollisionEffect.DEFAULT_SPAWN_DIRECTION,
         positionOffset: CGFloat = SpawnPowerupCollisionEffect.DEFAULT_POSITION_OFFSET) {
        self.powerupType = powerupType
        self.spawnDirection = spawnDirection
        self.positionOffset = positionOffset
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        guard let blockRenderableComponent = delegate.getComponent(of: RenderableComponent.self, for: collidee) else {
            return
        }
        let powerupPosition = calculatePowerupPosition(blockComponent: blockRenderableComponent)
        let createPowerupEvent = CreatePowerupEvent(powerupType: powerupType, position: powerupPosition)
        delegate.removeComponents(of: CollisionEffectComponent.self, for: collidee)
        EventManager.shared.postEvent(createPowerupEvent)
    }

    private func calculatePowerupPosition(blockComponent: RenderableComponent) -> CGPoint {
        let blockPosition = blockComponent.position
        let blockSize = blockComponent.size
        var offsetVector = CGVector.zero

        switch spawnDirection {
        case .up:
            offsetVector = CGVector(dx: 0, dy: -blockSize.height / 2 - positionOffset)
        case .down:
            offsetVector = CGVector(dx: 0, dy: (blockSize.height / 2 + positionOffset))
        case .left:
            offsetVector = CGVector(dx: -(blockSize.width / 2 - positionOffset), dy: 0)
        case .right:
            offsetVector = CGVector(dx: blockSize.width / 2 + positionOffset, dy: 0)
        }

        return blockPosition + offsetVector
    }
}
