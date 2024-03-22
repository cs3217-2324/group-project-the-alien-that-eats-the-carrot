//
//  Nexus+Extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

extension Nexus {
    func addCharacter() {
        let entity = Entity()
        let positionalComponent = PositionalComponent(entity: entity, position: CGPoint(x: 200, y: 200))
        let playerComponent = PlayerComponent(entity: entity)
        let destroyableComponent = DestroyableComponent(entity: entity)
        let movableComponent = MovableComponent(entity: entity, direction: Direction.right, velocity: 10.0)
        addComponents([positionalComponent, playerComponent, destroyableComponent, movableComponent], to: entity)
    }

    /// Factory to create game objects
    func addGameObject(type: ObjectType) {
        let entity = Entity()

        switch type {
        case .enemy(let enemyType):
            addGameEnemy(type: enemyType)
        case .block(let blockType):
            addGameBlock(type: blockType)
        case .collectable(let collectableType):
            addGameCollectable(type: collectableType)
        case .powerup(let powerupType):
            addGamePowerup(type: powerupType)
        case .character(let characterType):
            addGameCharacter(type: characterType)
        }
    }
}

extension Nexus {
    private func addGameEnemy(type: ObjectType.EnemyType) {
        switch type {
        case .normal:
            print("TODO: implement")
        case .fast:
            print("TODO: implement")
        case .stationary:
            print("TODO: implement")
        case .turret:
            print("TODO: implement")
        }
    }

    private func addGameBlock(type: ObjectType.BlockType) {
        switch type {
        case .normal:
            print("TODO: implement")
        case .ground:
            print("TODO: implement")
        case .breakable:
            print("TODO: implement")
        case .pushable:
            print("TODO: implement")
        case .spike:
            print("TODO: implement")
        case .powerup:
            print("TODO: implement")
        }
    }

    private func addGameCollectable(type: ObjectType.CollectableType) {
        switch type {
        case .coin:
            print("TODO: implement")
        case .carrot:
            print("TODO: implement")
        case .heart:
            print("TODO: implement")
        }
    }

    private func addGamePowerup(type: ObjectType.PowerupType) {
        switch type {
        case .attack:
            print("TODO: implement")
        case .doubleJump:
            print("TODO: implement")
        case .invinsible:
            print("TODO: implement")
        case .strength:
            print("TODO: implement")
        }
    }

    private func addGameCharacter(type: ObjectType.CharacterType) {
        switch type {
        case .normal:
            print("TODO: implement")
        }
    }
}
