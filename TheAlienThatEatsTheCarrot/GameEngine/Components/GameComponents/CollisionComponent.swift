//
//  CollisionComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 2/4/24.
//

import CoreGraphics

class CollisionComponent: Component {
    let entity: Entity
    let collidedEntity: Entity

    init(entity: Entity, collidedEntity: Entity) {
        self.entity = entity
        self.collidedEntity = collidedEntity
    }
}
