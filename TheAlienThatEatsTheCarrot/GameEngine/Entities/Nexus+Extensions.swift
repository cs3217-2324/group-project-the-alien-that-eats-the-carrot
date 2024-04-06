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
        let normalCharacterFactory = NormalCharacterFactory(entity: entity)
        let components = normalCharacterFactory.createComponents()
        addComponents(components, to: entity)
    }

    /// Factory to create entities
    func addEntity(from boardObject: BoardObject) {
        let type = boardObject.type
        let entity = Entity()
        var factory: EntityFactory
        switch type {
        case .enemy(let enemyType):
            guard let enemy = boardObject as? Enemy else {
                return
            }
            factory = getEnemyFactory(type: enemyType, from: entity, enemy: enemy)
        case .block(let blockType):
            guard let block = boardObject as? Block else {
                return
            }
            factory = getBlockFactory(type: blockType, from: entity, block: block)
        case .collectable(let collectableType):
            guard let collectable = boardObject as? Collectable else {
                return
            }
            factory = getCollectableFactory(type: collectableType, from: entity,
                                            collectable: collectable)
        case .powerup(let powerupType):
            guard let powerup = boardObject as? Powerup else {
                return
            }
            factory = getPowerupFactory(type: powerupType, from: entity, powerup: powerup)
        case .character(let characterType):
            factory = getCharacterFactory(type: characterType, from: entity)
        }
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }
}

extension Nexus {
    private func getEnemyFactory(type: EnemyType, from entity: Entity,
                                 enemy: Enemy) -> EntityFactory {
        switch type {
        case .normal:
            return getNormalEnemyFactory(from: entity, enemy: enemy)
        case .fast:
            return getFastEnemyFactory(from: entity, enemy: enemy)
        case .stationary:
            fatalError("TODO: implement")
        case .turret:
            fatalError("TODO: implement")
        }
    }

    private func getBlockFactory(type: BlockType, from entity: Entity,
                                 block: Block) -> EntityFactory {
        switch type {
        case .normal:
            return getNormalBlockFactory(from: entity, block: block)
        case .ground:
            return getGroundBlockFactory(from: entity, block: block)
        case .breakable:
            fatalError("TODO: implement")
        case .pushable:
            return getPushableBlockFactory(from: entity, block: block)
        case .spike:
            return getSpikeBlockFactory(from: entity, block: block)
        case .powerup:
            fatalError("TODO: implement")
        }
    }

    private func getCollectableFactory(type: CollectableType, from entity: Entity,
                                       collectable: Collectable) -> EntityFactory {
        switch type {
        case .coin:
            return getCoinCollectableFactory(from: entity, collectable: collectable)
        case .carrot:
            return getCarrotCollectableFactory(from: entity, collectable: collectable)
        case .heart:
            return getHeartCollectableFactory(from: entity, collectable: collectable)
        }
    }

    private func getPowerupFactory(type: PowerupType, from entity: Entity,
                                   powerup: Powerup) -> EntityFactory {
        switch type {
        case .attack:
            fatalError("TODO: implement")
        case .doubleJump:
            return getDoubleJumpPowerupFactory(from: entity, powerup: powerup)
        case .invinsible:
            return getInvinsiblePowerupFactory(from: entity, powerup: powerup)
        case .strength:
            return getStrengthPowerupFactory(from: entity, powerup: powerup)
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
    private func getNormalEnemyFactory(from entity: Entity,
                                       enemy: Enemy) -> EntityFactory {
        NormalEnemyFactory(from: enemy, to: entity)
    }

    private func getFastEnemyFactory(from entity: Entity,
                                     enemy: Enemy) -> EntityFactory {
        FastEnemyFactory(from: enemy, to: entity)
    }
}

// MARK: Blocks
extension Nexus {
    private func getNormalBlockFactory(from entity: Entity,
                                       block: Block) -> EntityFactory {
        NormalBlockFactory(from: block, to: entity)
    }

    private func getGroundBlockFactory(from entity: Entity,
                                       block: Block) -> EntityFactory {
        GroundBlockFactory(from: block, to: entity)
    }

    private func getSpikeBlockFactory(from entity: Entity,
                                      block: Block) -> EntityFactory {
        SpikeBlockFactory(from: block, to: entity)
    }

    private func getPushableBlockFactory(from entity: Entity,
                                         block: Block) -> EntityFactory {
        PushableBlockFactory(from: block, to: entity)
    }

    private func getPowerupBlockFactory(from entity: Entity,
                                        block: Block) -> EntityFactory {
        PushableBlockFactory(from: block, to: entity)
    }
}

// MARK: Powerups
extension Nexus {
    private func getStrengthPowerupFactory(from entity: Entity,
                                           powerup: Powerup) -> EntityFactory {
        StrengthPowerupFactory(boardObject: powerup, entity: entity)
    }

    private func getInvinsiblePowerupFactory(from entity: Entity,
                                             powerup: Powerup) -> EntityFactory {
        StrengthPowerupFactory(boardObject: powerup, entity: entity)
    }

    private func getDoubleJumpPowerupFactory(from entity: Entity,
                                             powerup: Powerup) -> EntityFactory {
        StrengthPowerupFactory(boardObject: powerup, entity: entity)
    }
}

// MARK: Collectables
extension Nexus {
    private func getCoinCollectableFactory(from entity: Entity,
                                           collectable: Collectable) -> EntityFactory {
        CoinCollectableFactory(boardObject: collectable, entity: entity)
    }

    private func getCarrotCollectableFactory(from entity: Entity,
                                             collectable: Collectable) -> EntityFactory {
        DoubleJumpPowerupFactory(boardObject: collectable, entity: entity)
    }

    private func getHeartCollectableFactory(from entity: Entity,
                                            collectable: Collectable) -> EntityFactory {
        HeartCollectableFactory(boardObject: collectable, entity: entity)
    }
}
