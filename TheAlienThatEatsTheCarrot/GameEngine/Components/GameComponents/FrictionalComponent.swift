//
//  FrictionalComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

class FrictionalComponent: Component {
    static let DEFAULT_FRICTION_STRENGTH = 200.0
    var entity: Entity
    var frictionalStrength: CGFloat

    init(entity: Entity, frictionalStrength: CGFloat = FrictionalComponent.DEFAULT_FRICTION_STRENGTH) {
        self.entity = entity
        self.frictionalStrength = frictionalStrength
    }
}
