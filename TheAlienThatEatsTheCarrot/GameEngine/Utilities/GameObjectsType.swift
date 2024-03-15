//
//  GameObjectsType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

enum GameObjectsType {
    case enemy(EnemyType)
    case block(BlockType)
    case collectable(CollectableType)
    case powerup(PowerupType)

    enum EnemyType {
        case normal, fast, stationary, turret
    }

    enum BlockType {
        case normal, ground, spike, breakable, pushable
    }

    enum CollectableType {
        case coin, carrot, heart
    }

    enum PowerupType {
        case invinsible, strength, attack, doubleJump
    }
}
