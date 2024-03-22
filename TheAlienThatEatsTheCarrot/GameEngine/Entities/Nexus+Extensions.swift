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
    func addEntity(type: ObjectType) {
        let entity = Entity()
        var factory: EntityFactory
        switch type {
        case .enemy(let enemyType):
            factory = getEnemyFactory(type: enemyType, from: entity)
        case .block(let blockType):
            factory = getBlockFactory(type: blockType, from: entity)
        case .collectable(let collectableType):
            factory = getCollectableFactory(type: collectableType, from: entity)
        case .powerup(let powerupType):
            factory = getPowerupFactory(type: powerupType, from: entity)
        case .character(let characterType):
            factory = getCharacterFactory(type: characterType, from: entity)
        }
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }
}

extension Nexus {
    private func getEnemyFactory(type: ObjectType.EnemyType, from entity: Entity) -> EntityFactory {
        switch type {
        case .normal:
            fatalError("TODO: implement")
        case .fast:
            fatalError("TODO: implement")
        case .stationary:
            fatalError("TODO: implement")
        case .turret:
            fatalError("TODO: implement")
        }
    }

    private func getBlockFactory(type: ObjectType.BlockType, from entity: Entity) -> EntityFactory {
        switch type {
        case .normal:
            return getNormalBlockFactory(from: entity)
        case .ground:
            return getGroundBlockFactory(from: entity)
        case .breakable:
            fatalError("TODO: implement")
        case .pushable:
            fatalError("TODO: implement")
        case .spike:
            fatalError("TODO: implement")
        case .powerup:
            fatalError("TODO: implement")
        }
    }

    private func getCollectableFactory(type: ObjectType.CollectableType, from entity: Entity) -> EntityFactory {
        switch type {
        case .coin:
            fatalError("TODO: implement")
        case .carrot:
            fatalError("TODO: implement")
        case .heart:
            fatalError("TODO: implement")
        }
    }

    private func getPowerupFactory(type: ObjectType.PowerupType, from entity: Entity) -> EntityFactory {
        switch type {
        case .attack:
            fatalError("TODO: implement")
        case .doubleJump:
            fatalError("TODO: implement")
        case .invinsible:
            fatalError("TODO: implement")
        case .strength:
            fatalError("TODO: implement")
        }
    }

    private func getCharacterFactory(type: ObjectType.CharacterType, from entity: Entity) -> EntityFactory {
        switch type {
        case .normal:
            fatalError("TODO: implement")
        }
    }
}

extension Nexus {
    private func getNormalEnemyFactory(from entity: Entity) -> EntityFactory {
        let entity = Entity()
        // TODO: get this from persistence
        let normalEnemyBoardObject = NormalEnemy()
        return NormalEnemyFactory(from: normalEnemyBoardObject, to: entity)
    }

    private func getNormalBlockFactory(from entity: Entity) -> EntityFactory {
        let entity = Entity()
        // TODO: get this from persistence
        let normalBlockBoardObject = NormalBlock()
        return NormalBlockFactory(from: normalBlockBoardObject, to: entity)
    }

    private func getGroundBlockFactory(from entity: Entity) -> EntityFactory {
        let entity = Entity()
        // TODO: get this from persistence
        let groundBlockBoardObject = GroundBlock()
        return GroundBlockFactory(from: groundBlockBoardObject, to: entity)
    }
}
