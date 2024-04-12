//
//  RemoveComponentEffect.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class RemoveComponentEffect: CollisionEffect {
    let componentsToRemove: [Component.Type]
    let entity: Entity

    init(componentsToRemove: [Component.Type], removeFrom entity: Entity) {
        self.componentsToRemove = componentsToRemove
        self.entity = entity
    }

    func effectWhenCollide(with collidee: Entity, by collider: Entity, delegate: CollisionEffectDelegate) {
        for componentToRemove in componentsToRemove {
            delegate.removeComponents(of: componentToRemove, for: entity)
        }
    }
}
