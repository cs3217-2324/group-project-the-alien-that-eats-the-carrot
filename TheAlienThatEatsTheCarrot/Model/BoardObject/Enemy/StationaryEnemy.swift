//
//  StationaryEnemy.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class StationaryEnemy: Enemy {
    static let STATIONARY_ENEMY_WIDTH: CGFloat = 50.0
    static let STATIONARY_ENEMY_HEIGHT: CGFloat = 50.0
    // TODO: update when adding asset
    static let imageName = ""
    static let type = ObjectType.EnemyType.stationary

    init(position: CGPoint = .zero, width: CGFloat = STATIONARY_ENEMY_WIDTH, height: CGFloat = STATIONARY_ENEMY_HEIGHT) {
        super.init(imageName: StationaryEnemy.imageName, width: width, height: height, position: position)
    }
}
