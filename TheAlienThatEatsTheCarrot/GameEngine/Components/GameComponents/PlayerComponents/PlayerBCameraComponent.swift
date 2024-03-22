//
//  PlayerBCameraComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class PlayerBCameraComponent: Component {
    var entity: Entity
    var cameraBounds: CGRect

    init(entity: Entity, cameraBounds: CGRect = GameConstants.DEFAULT_CAMERA_BOUNDS) {
        self.entity = entity
        self.cameraBounds = cameraBounds
    }
}
