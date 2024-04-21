//
//  GameObjectsType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

public enum ObjectType: Equatable, Hashable {
    case enemy(EnemyType)
    case block(BlockType)
    case collectable(CollectableType)
    case powerup(PowerupType)
    case character(CharacterType)
    case projectile(ProjectileType)

    var assetName: String? {
        switch self {
        case .enemy(let enemyType):
            return enemyType.assetName
        case .block(let blockType):
            return blockType.assetName
        case .collectable(let collectableType):
            return collectableType.assetName
        case .powerup(let powerupType):
            return powerupType.assetName
        case .character(let characterType):
            return characterType.assetName
        case .projectile(let projectileType):
            return projectileType.assetName
        }
    }

    var size: CGSize? {
        switch self {
        case .enemy(let enemyType):
            return enemyType.size
        case .block(let blockType):
            return blockType.size
        case .collectable(let collectableType):
            return collectableType.size
        case .powerup(let powerupType):
            return powerupType.size
        case .character(let characterType):
            return characterType.size
        case .projectile(let projectileType):
            return projectileType.size
        }
    }

    // Factory method to create instances based on ObjectType
    static func createObject(from objectType: ObjectType, position: CGPoint) -> any BoardObject {
        switch objectType {
        case .enemy(let enemyType):
            return createEnemy(from: enemyType, position: position)
        case .block(let blockType):
            return createBlock(from: blockType, position: position)
        case .collectable(let collectableType):
            return createCollectable(from: collectableType, position: position)
        case .powerup(let powerupType):
            return createPowerup(from: powerupType, position: position)
        case .character(let characterType):
            return createCharacter(from: characterType, position: position)
        case .projectile:
            fatalError("Projectile has no board object")
        }
    }

    static func createEnemy(from enemyType: EnemyType, position: CGPoint) -> Enemy {
        Enemy(enemyType: enemyType, position: position)
    }

    static func createBlock(from blockType: BlockType, position: CGPoint) -> Block {
        Block(blockType: blockType, containedPowerupType: nil, position: position)
    }

    static func createCollectable(from collectableType: CollectableType, position: CGPoint) -> Collectable {
        Collectable(collectableType: collectableType, position: position)
    }

    static func createPowerup(from powerupType: PowerupType, position: CGPoint) -> Powerup {
        Powerup(powerupType: powerupType, position: position)
    }

    static func createCharacter(from characterType: CharacterType, position: CGPoint) -> Character {
        Character(characterType: characterType, position: position)
    }
}
