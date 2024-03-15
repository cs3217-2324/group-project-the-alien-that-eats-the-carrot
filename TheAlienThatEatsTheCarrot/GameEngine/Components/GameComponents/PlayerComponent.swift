//
//  PlayerComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class PlayerComponent: Component {
    var entity: Entity
    
    init(entity: Entity) {
        self.entity = entity
    }
}
