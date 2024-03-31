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
        let attackableComponents = nexus.getComponents(of: AttackableComponent.self)
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for attackableComponent in attackableComponents {
            for playerComponent in playerComponents {
                // Note that the attackIfPossible handles the logic to determine if the player should be attacked
                attackableComponent.attackIfPossible(attackee: playerComponent.entity, delegate: self)
            }
        }
    }

    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

}
