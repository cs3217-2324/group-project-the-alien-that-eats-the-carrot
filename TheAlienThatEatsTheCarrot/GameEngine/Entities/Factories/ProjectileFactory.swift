//
//  ProjectileFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

class ProjectileFactory: EntityFactory {
    static let DEFAULT_LIFESPAN = 3.0
    var entity: Entity
    let velocity: CGVector
    let position: CGPoint
    let size: CGSize
    let lifespan: CGFloat
    var targetables: [Component.Type]

    init(entity: Entity,
         velocity: CGVector,
         position: CGPoint,
         size: CGSize,
         lifespan: CGFloat = ProjectileFactory.DEFAULT_LIFESPAN,
         targetables: [Component.Type]) {
        self.entity = entity
        self.velocity = velocity
        self.position = position
        self.size = size
        self.lifespan = lifespan
        self.targetables = targetables
    }

    func createComponents() -> [Component] {
        []
    }
}
