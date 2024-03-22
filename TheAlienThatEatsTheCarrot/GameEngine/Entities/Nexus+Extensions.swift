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

    /// Factory to create entities
    func addEntity(type: ObjectType, at point: CGPoint) {
        switch type {
        case .enemy(let enemyType):
            addEnemyEntity(type: enemyType, at: point)
        case .block(let blockType):
            addBlockEntity(type: blockType, at: point)
        case .collectable(let collectableType):
            addCollectableEntity(type: collectableType, at: point)
        case .powerup(let powerupType):
            addPowerupEntity(type: powerupType, at: point)
        case .character(let characterType):
            addCharacterEntity(type: characterType, at: point)
        }
    }
}

extension Nexus {
    private func addEnemyEntity(type: ObjectType.EnemyType, at point: CGPoint) {
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

    private func addBlockEntity(type: ObjectType.BlockType, at point: CGPoint) {
        switch type {
        case .normal:
            addNormalBlockEntity(at: point)
        case .ground:
            addGroundBlockEntity(at: point)
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

    private func addCollectableEntity(type: ObjectType.CollectableType, at point: CGPoint) {
        switch type {
        case .coin:
            print("TODO: implement")
        case .carrot:
            print("TODO: implement")
        case .heart:
            print("TODO: implement")
        }
    }

    private func addPowerupEntity(type: ObjectType.PowerupType, at point: CGPoint) {
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

    private func addCharacterEntity(type: ObjectType.CharacterType, at point: CGPoint) {
        switch type {
        case .normal:
            print("TODO: implement")
        }
    }
}

extension Nexus {
    private func addNormalEnemyEntity(at point: CGPoint) {
        let entity = Entity()
        // TODO: get this from persistence
        let normalEnemyBoardObject = NormalEnemy()
        let factory = NormalEnemyFactory(from: normalEnemyBoardObject, to: entity)
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }

    private func addNormalBlockEntity(at point: CGPoint) {
        let entity = Entity()
        // TODO: get this from persistence
        let normalBlockBoardObject = NormalBlock()
        let factory = NormalBlockFactory(from: normalBlockBoardObject, to: entity)
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }

    private func addGroundBlockEntity(at point: CGPoint) {
        let entity = Entity()
        // TODO: get this from persistence
        let groundBlockBoardObject = GroundBlock()
        let factory = GroundBlockFactory(from: groundBlockBoardObject, to: entity)
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }
}
