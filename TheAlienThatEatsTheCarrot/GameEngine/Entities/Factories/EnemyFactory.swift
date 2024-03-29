//
//  EnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class EnemyFactory: EntityFactory {
    let boardObject: Enemy
    let entity: Entity

    init(from boardObject: Enemy, to entity: Entity) {
        self.boardObject = boardObject
        self.entity = entity
    }

    func createComponents() -> [Component] {
        []
    }
}
