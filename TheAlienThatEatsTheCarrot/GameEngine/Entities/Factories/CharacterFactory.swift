//
//  CharacterFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class CharacterFactory: EntityFactory {
    var entity: Entity
    var position: CGPoint

    init(entity: Entity, position: CGPoint) {
        self.entity = entity
        self.position = position
    }

    func createComponents() -> [Component] {
        []
    }
}
