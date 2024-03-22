//
//  TurretEnemy.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class TurretEnemy: Enemy {
    static let TURRET_ENEMY_WIDTH: CGFloat = 50.0
    static let TURRET_ENEMY_HEIGHT: CGFloat = 50.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .enemy(.turret)
    }
    
    init(position: CGPoint = .zero, width: CGFloat = TURRET_ENEMY_WIDTH, height: CGFloat = TURRET_ENEMY_HEIGHT) {
        super.init(imageName: TurretEnemy.imageName, width: width, height: height, position: position)
    }
}
