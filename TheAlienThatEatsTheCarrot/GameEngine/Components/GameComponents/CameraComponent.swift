//
//  PlayerBCameraComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class CameraComponent: Component {
    var entity: Entity
    var cameraBounds: CGRect
    var toRender: [RenderableComponent] = []

    init(entity: Entity, cameraBounds: CGRect = GameConstants.DEFAULT_CAMERA_BOUNDS) {
        self.entity = entity
        self.cameraBounds = cameraBounds
    }

    func updateCameraBoundsFromCenter(center: CGPoint) {
        let size = cameraBounds.size
        var newOriginX = center.x - size.width / 2
        var newOriginY = center.y - size.height / 2

        // When the player moves to the boundaries, the camera should not move beyond what is available
        newOriginX = max(newOriginX, 0)
        newOriginY = max(newOriginY, 0)

        cameraBounds.origin = CGPoint(x: newOriginX, y: newOriginY)
    }

    func resetToRender() {
        self.toRender = []
    }
}
