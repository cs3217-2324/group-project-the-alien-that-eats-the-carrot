//
//  GameObjectsType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

public enum ObjectType {
    case enemy(EnemyType)
    case block(BlockType)
    case collectable(CollectableType)
    case powerup(PowerupType)
    case character(CharacterType)
}
