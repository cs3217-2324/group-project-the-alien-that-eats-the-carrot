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

    public enum EnemyType {
        case normal, fast, stationary, turret
    }

    public enum BlockType {
        case normal, ground, spike, breakable, pushable, powerup
    }

    public enum CollectableType {
        case coin, carrot, heart
    }

    public enum PowerupType {
        case invinsible, strength, attack, doubleJump
    }
    
    public enum CharacterType {
        case normal
    }
}
