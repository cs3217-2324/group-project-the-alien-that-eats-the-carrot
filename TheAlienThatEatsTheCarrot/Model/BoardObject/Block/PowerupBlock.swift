//
//  PowerupBlock.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class PowerupBlock: Block {
    var powerupsContained: [Powerup]
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .block(.powerup)
    }

    init(position: CGPoint = .zero, powerups: [Powerup] = []) {
        self.powerupsContained = powerups
        super.init(imageName: PowerupBlock.imageName, position: position)
    }
}
