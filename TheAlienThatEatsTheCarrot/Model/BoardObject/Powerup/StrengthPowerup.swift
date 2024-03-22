//
//  StrengthPowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class StrengthPowerup: Powerup {
    static let STRENGTH_POWERUP_WIDTH: CGFloat = 20.0
    static let STRENGTH_POWERUP_HEIGHT: CGFloat = 30.0
    // TODO: update when adding asset
    override var type: ObjectType {
        .powerup(.strength)
    }

    init(position: CGPoint = .zero, width: CGFloat = StrengthPowerup.STRENGTH_POWERUP_WIDTH, height: CGFloat = StrengthPowerup.STRENGTH_POWERUP_HEIGHT) {
        super.init(imageName: StrengthPowerup.imageName, width: width, height: height, position: position)
    }
}
