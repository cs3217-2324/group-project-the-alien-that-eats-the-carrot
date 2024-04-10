//
//  GameComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/4/24.
//

import Foundation

class GameComponent: Component {
    var entity: Entity

    init(entity: Entity) {
        self.entity = entity
    }
}
