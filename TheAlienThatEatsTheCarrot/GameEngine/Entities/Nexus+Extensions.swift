//
//  Nexus+Extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

extension Nexus {
    func addCharacter() {
        let entity = Entity()
        let positionalComponent = PositionalComponent(entity: entity, position: CGPoint(x: 200, y: 200))
        let playerComponent = PlayerComponent(entity: entity)
        let destroyableComponent = DestroyableComponent(entity: entity)
        let movableComponent = MovableComponent(entity: entity, direction: Direction.right, length: 10.0)
        addComponents([positionalComponent, playerComponent, destroyableComponent, movableComponent], to: entity)
    }
}
