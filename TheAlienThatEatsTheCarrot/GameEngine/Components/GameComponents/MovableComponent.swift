//
//  MovableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class MovableComponent: Component {
    var entity: Entity
    var direction: Direction
    var length: CGFloat
    
    init(entity: Entity, direction: Direction, length: CGFloat) {
        self.entity = entity
        self.direction = direction
        self.length = length
    }
}
