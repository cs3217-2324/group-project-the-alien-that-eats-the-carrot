//
//  CharacterFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 2/4/24.
//

import Foundation

class CharacterFactory: EntityFactory {
    var entity: Entity

    init(entity: Entity) {
        self.entity = entity
    }

    func createComponents() -> [Component] {
        []
    }
}
