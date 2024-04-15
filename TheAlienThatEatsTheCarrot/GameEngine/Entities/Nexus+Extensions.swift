//
//  Nexus+Extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

extension Nexus {
    func addGameSettings(for gameSettings: GameSettings) {
        let entity = Entity()
        let gameSettingsComponent = GameSettingsComponent(entity: entity, spawnPoint: gameSettings.spawnPoint)
        addComponent(gameSettingsComponent, to: entity)
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
            guard let character = boardObject as? Character else {
                return
            }
            factory = getCharacterFactory(type: characterType, from: entity, character: character)
        case .projectile(let projectileType):
            fatalError("Board object does not have projectile")
        }
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }

    /// For game
    func addGameEntity(with bounds: CGRect) {
        let entity = Entity()
        let factory = GameEntityFactory(entity: entity, bounds: bounds)
        let components = factory.createComponents()
        addComponents(components, to: entity)
    }

    /// Factory for projectile
    func addProjectile(type: ProjectileType, velocity: CGVector, position: CGPoint,
                       size: CGSize, targetables: [Component.Type],
                       dissapearWhenCollideWith: [Component.Type]) {
        let entity = Entity()
        var factory: EntityFactory
        switch type {
        case .pellet:
            factory = getPelletProjectileFactory(from: entity, velocity: velocity, position: position,
                                                 targetables: targetables,
                                                 dissapearWhenCollideWith: dissapearWhenCollideWith)
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
            return getStationaryEnemyFactory(from: entity, enemy: enemy)
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
            return getBreakableBlockFactory(from: entity, block: block)
        case .pushable:
            return getPushableBlockFactory(from: entity, block: block)
        case .spike:
            return getSpikeBlockFactory(from: entity, block: block)
        case .mushroom:
            return getMushroomBlockFactory(from: entity, block: block)
        case .roller:
            return getRollerBlockFactory(from: entity, block: block)
        case .temporary:
            return getTemporaryBlockFactory(from: entity, block: block)
        case .gravity:
            return getGravityBlockFactory(from: entity, block: block)
        case .doubleJumpPowerup:
            return getPowerupBlockFactory(from: entity, block: block, type: .doubleJump)
        case .strengthPowerup:
            return getPowerupBlockFactory(from: entity, block: block, type: .strength)
        case .attackPowerup:
            return getPowerupBlockFactory(from: entity, block: block, type: .attack)
        case .invinciblePowerup:
            return getPowerupBlockFactory(from: entity, block: block, type: .invinsible)
        case .exit:
            return getExitBlockFactory(from: entity, block: block)
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
            return getAttackPowerupFactory(from: entity, powerup: powerup)
        case .doubleJump:
            return getDoubleJumpPowerupFactory(from: entity, powerup: powerup)
        case .invinsible:
            return getInvinsiblePowerupFactory(from: entity, powerup: powerup)
        case .strength:
            return getStrengthPowerupFactory(from: entity, powerup: powerup)
        }
    }

    private func getCharacterFactory(type: CharacterType, from entity: Entity, character: Character) -> EntityFactory {
        switch type {
        case .normal:
            return getNormalCharacterFactory(from: entity, character: character)
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

    private func getStationaryEnemyFactory(from entity: Entity, enemy: Enemy) -> EntityFactory {
        StationaryEnemyFactory(from: enemy, to: entity)
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
                                        block: Block, type: PowerupType) -> EntityFactory {
        switch type {
        case .attack:
            return AttackPowerupBlockFactory(from: block, to: entity)
        case .doubleJump:
            return DoubleJumpPowerupBlockFactory(from: block, to: entity)
        case .strength:
            return StrengthPowerupBlockFactory(from: block, to: entity)
        case .invinsible:
            return InvinciblePowerupBlockFactory(from: block, to: entity)
        }
    }

    private func getMushroomBlockFactory(from entity: Entity, block: Block) -> EntityFactory {
        MushroomBlockFactory(from: block, to: entity)
    }

    private func getRollerBlockFactory(from entity: Entity, block: Block) -> EntityFactory {
        RollerBlockFactory(from: block, to: entity)
    }

    private func getTemporaryBlockFactory(from entity: Entity, block: Block) -> EntityFactory {
        TemporaryBlockFactory(from: block, to: entity)
    }

    private func getGravityBlockFactory(from entity: Entity, block: Block) -> EntityFactory {
        GravityBlockFactory(from: block, to: entity)
    }

    private func getBreakableBlockFactory(from entity: Entity, block: Block) -> EntityFactory {
        BreakableBlockFactory(from: block, to: entity)
    }

    private func getExitBlockFactory(from entity: Entity, block: Block) -> EntityFactory {
        ExitBlockFactory(from: block, to: entity)
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
        InvinciblePowerupFactory(boardObject: powerup, entity: entity)
    }

    private func getDoubleJumpPowerupFactory(from entity: Entity,
                                             powerup: Powerup) -> EntityFactory {
        DoubleJumpPowerupFactory(boardObject: powerup, entity: entity)
    }

    private func getAttackPowerupFactory(from entity: Entity,
                                         powerup: Powerup) -> EntityFactory {
        AttackPowerupFactory(boardObject: powerup, entity: entity)
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
        CarrotCollectableFactory(boardObject: collectable, entity: entity)
    }

    private func getHeartCollectableFactory(from entity: Entity,
                                            collectable: Collectable) -> EntityFactory {
        HeartCollectableFactory(boardObject: collectable, entity: entity)
    }
}

// MARK: Character factories
extension Nexus {
    private func getNormalCharacterFactory(from entity: Entity, character: Character) -> EntityFactory {
        NormalCharacterFactory(boardObject: character, entity: entity)
    }
}

// MARK: Projectile factories
extension Nexus {
    func getPelletProjectileFactory(from entity: Entity, velocity: CGVector,
                                    position: CGPoint,
                                    size: CGSize = GameConstants.DEFAULT_PROJECTILE_SIZE,
                                    targetables: [Component.Type],
                                    dissapearWhenCollideWith: [Component.Type]) -> EntityFactory {
        PelletProjectileFactory(entity: entity, velocity: velocity, position: position,
                                size: size, targetables: targetables,
                                dissapearWhenCollideWith: dissapearWhenCollideWith)
    }
}

// MARK: Utilities
extension Nexus {
    func updatePosition(for entity: Entity, to position: CGPoint) {
        guard let physicsComponent = self.getComponent(of: PhysicsComponent.self, for: entity),
              let renderableComponent = self.getComponent(of: RenderableComponent.self, for: entity) else {
            return
        }
        physicsComponent.physicsBody.position = position
        physicsComponent.physicsBody.velocity = .zero
        renderableComponent.position = position
    }
}
