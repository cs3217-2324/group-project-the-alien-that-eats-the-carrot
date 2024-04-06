//
//  RespawnableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class RespawnableComponent: Component {
    var entity: Entity
    var spawnPoint: CGPoint

    init(entity: Entity, spawnPoint: CGPoint) {
        self.entity = entity
        self.spawnPoint = spawnPoint
    }
}
