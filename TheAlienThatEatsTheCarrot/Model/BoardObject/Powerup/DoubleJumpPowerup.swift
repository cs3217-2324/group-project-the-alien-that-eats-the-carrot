//
//  DoubleJumpPowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class DoubleJumpPowerup: Powerup {
    static let DOUBLE_JUMP_POWERUP_WIDTH: CGFloat = 20.0
    static let DOUBLE_JUMP_POWERUP_HEIGHT: CGFloat = 20.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .powerup(.doubleJump)
    }

    init(position: CGPoint = .zero, width: CGFloat = DoubleJumpPowerup.DOUBLE_JUMP_POWERUP_WIDTH,
         height: CGFloat = DoubleJumpPowerup.DOUBLE_JUMP_POWERUP_HEIGHT) {
        super.init(imageName: DoubleJumpPowerup.imageName, width: width, height: height, position: position)
    }
}
