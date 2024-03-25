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
        }
    }
}
