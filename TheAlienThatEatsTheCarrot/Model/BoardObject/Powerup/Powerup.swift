//
//  Powerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class Powerup: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    var powerupType: PowerupType
    var type: ObjectType {
        .powerup(self.powerupType)
    }

    init(powerupType: PowerupType, position: CGPoint = .zero) {
        self.powerupType = powerupType
        self.position = position
        self.imageName = powerupType.assetName
        self.width = powerupType.width
        self.height = powerupType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
