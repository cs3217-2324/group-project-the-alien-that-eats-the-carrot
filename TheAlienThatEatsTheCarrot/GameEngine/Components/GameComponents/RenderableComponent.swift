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
    var size: CGSize

    init(entity: Entity, position: CGPoint, size: CGSize = GameConstants.DEFAULT_ASSET_SIZE) {
        self.entity = entity
        self.position = position
        self.size = size
    }
}
