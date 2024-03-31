//
//  DamageSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class DamageSystem: System, AttackableDelegate {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let attackableComponents = nexus.getComponents(of: AttackableComponent.self)
        let destroyableComponents = nexus.getComponents(of: DestroyableComponent.self)
        for attackableComponent in attackableComponents {
            for destroyableComponent in destroyableComponents {
                attackableComponent.attackIfPossible(attackee: destroyableComponent.entity, delegate: self)
            }
        }
    }

    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }

}
