//
//  FastEnemy.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class FastEnemy: Enemy {
    static let FAST_ENEMY_WIDTH: CGFloat = 50.0
    static let FAST_ENEMY_HEIGHT: CGFloat = 50.0
    // TODO: update when adding asset
    static let imageName = ""
    static let type = ObjectType.EnemyType.fast

    init(position: CGPoint = .zero, width: CGFloat = FAST_ENEMY_WIDTH, height: CGFloat = FAST_ENEMY_HEIGHT) {
        super.init(imageName: FastEnemy.imageName, width: width, height: height, position: position)
    }
}
