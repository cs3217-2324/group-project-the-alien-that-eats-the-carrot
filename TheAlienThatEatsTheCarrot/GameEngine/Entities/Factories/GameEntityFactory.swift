//
//  GameEntityFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class GameEntityFactory: EntityFactory {
    var entity: Entity
    var bounds: CGRect

    init(entity: Entity, bounds: CGRect) {
        self.entity = entity
        self.bounds = bounds
    }

    func createComponents() -> [Component] {
        let attackStyle = AttackIfOutOfBoundsAttackStyle(bounds: bounds)
        let attackableComponent = AttackableComponent(entity: entity, attackStyles: [attackStyle])
        return [attackableComponent]
    }
}
