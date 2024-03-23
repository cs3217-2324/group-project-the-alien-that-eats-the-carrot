//
//  renderableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class RenderableComponent: Component {
    var entity: Entity
    var position: CGPoint

    init(entity: Entity, position: CGPoint) {
        self.entity = entity
        self.position = position
    }
}
