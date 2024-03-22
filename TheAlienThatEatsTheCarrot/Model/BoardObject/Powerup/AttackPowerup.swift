//
//  AttackPowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class AttackPowerup: Powerup {
    static let ATTACK_POWERUP_WIDTH: CGFloat = 30.0
    static let ATTACK_POWERUP_HEIGHT: CGFloat = 30.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .powerup(.attack)
    }

    init(position: CGPoint = .zero, width: CGFloat = AttackPowerup.ATTACK_POWERUP_WIDTH,
         height: CGFloat = AttackPowerup.ATTACK_POWERUP_HEIGHT) {
        super.init(imageName: AttackPowerup.imageName, width: width, height: height, position: position)
    }
}
