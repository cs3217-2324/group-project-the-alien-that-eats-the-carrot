//
//  Nexus+Extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

extension Nexus {
    func addCharacterForPlayerA() {
        let entity = Entity()
        let renderableComponent = RenderableComponent(entity: entity, position: CGPoint(x: 200, y: 200), objectType: .character(.normal))
        let playerComponent = PlayerComponent(entity: entity)
        let cameraComponent = CameraComponent(entity: entity)
        let attackableComponent = AttackableComponent(entity: entity)
        let destroyableComponent = DestroyableComponent(entity: entity)
        addComponents([renderableComponent, playerComponent, cameraComponent, attackableComponent,
                       destroyableComponent], to: entity)
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
    private func getEnemyFactory(type: EnemyType, from entity: Entity) -> EntityFactory {
        switch type {
        case .normal:
            return getNormalEnemyFactory(from: entity)
        case .fast:
            fatalError("TODO: implement")
        case .stationary:
            fatalError("TODO: implement")
        case .turret:
            fatalError("TODO: implement")
        }
    }

    private func getBlockFactory(type: BlockType, from entity: Entity) -> EntityFactory {
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

    private func getCollectableFactory(type: CollectableType, from entity: Entity) -> EntityFactory {
        switch type {
        case .coin:
            fatalError("TODO: implement")
        case .carrot:
            fatalError("TODO: implement")
        case .heart:
            fatalError("TODO: implement")
        }
    }

    private func getPowerupFactory(type: PowerupType, from entity: Entity) -> EntityFactory {
        switch type {
        case .attack:
            fatalError("TODO: implement")
        case .doubleJump:
            fatalError("TODO: implement")
        case .invinsible:
            fatalError("TODO: implement")
        case .strength:
            return getStrengthPowerupFactory(from: entity)
        }
    }

    private func getCharacterFactory(type: CharacterType, from entity: Entity) -> EntityFactory {
        switch type {
        case .normal:
            fatalError("TODO: implement")
        }
    }
}

// MARK: Enemies
extension Nexus {
    private func getNormalEnemyFactory(from entity: Entity) -> EntityFactory {
        // TODO: get this from persistence
        let normalEnemyBoardObject = Enemy(enemyType: .normal)
        return NormalEnemyFactory(from: normalEnemyBoardObject, to: entity)
    }
}

// MARK: Blocks
extension Nexus {
    private func getNormalBlockFactory(from entity: Entity) -> EntityFactory {
        // TODO: get this from persistence
        let normalBlockBoardObject = Block(blockType: .normal, containedPowerupType: nil)
        return NormalBlockFactory(from: normalBlockBoardObject, to: entity)
    }

    private func getGroundBlockFactory(from entity: Entity) -> EntityFactory {
        // TODO: get this from persistence
        let groundBlockBoardObject = Block(blockType: .ground, containedPowerupType: nil)
        return GroundBlockFactory(from: groundBlockBoardObject, to: entity)
    }
}

// MARK: Powerups
extension Nexus {
    private func getStrengthPowerupFactory(from entity: Entity) -> EntityFactory {
        let powerupBlockObject = Powerup(powerupType: .strength, position: CGPoint(x: 200.0, y: 200.0))
        return StrengthPowerupFactory(boardObject: powerupBlockObject, entity: entity)
    }
}
