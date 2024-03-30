//
//  PlayerDamageSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

/// Responsible to handling damage to players by blocks / enemies
class PlayerDamageSystem: System, AttackableDelegate {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        damagePlayersWithBlocks()
        damagePlayersWithEnemies()
    }

    private func damagePlayersWithBlocks() {
        let attackableBlockEntities = nexus.getEntities(withComponentTypes: [BlockComponent.self, AttackableComponent.self])
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for attackableBlockEntity in attackableBlockEntities {
            guard
                let attackableComponent = nexus.getComponent(of: AttackableComponent.self, for: attackableBlockEntity) else {
                return
            }
            for playerComponent in playerComponents {
                attackableComponent.attackIfPossible(attackee: playerComponent.entity, delegate: self)
            }
        }
    }

    private func damagePlayersWithEnemies() {
        let attackableEnemyEntities = nexus.getEntities(withComponentTypes: [EnemyComponent.self, AttackableComponent.self])
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for attackableEnemyEntity in attackableEnemyEntities {
            guard
                let attackableComponent = nexus.getComponent(of: AttackableComponent.self, for: attackableEnemyEntity) else {
                return
            }
            for playerComponent in playerComponents {
                attackableComponent.attackIfPossible(attackee: playerComponent.entity, delegate: self)
            }
        }
    }

    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

}
