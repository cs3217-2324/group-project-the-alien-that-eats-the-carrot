//
//  InvinciblePowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class InvinciblePowerup: Powerup {
    static let INVINCIBLE_POWERUP_WIDTH: CGFloat = 30.0
    static let INVINCIBLE_POWERUP_HEIGHT: CGFloat = 30.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .powerup(.invinsible)
    }

    init(position: CGPoint = .zero, width: CGFloat = InvinciblePowerup.INVINCIBLE_POWERUP_WIDTH,
         height: CGFloat = InvinciblePowerup.INVINCIBLE_POWERUP_HEIGHT) {
        super.init(imageName: InvinciblePowerup.imageName, width: width, height: height, position: position)
    }
}
