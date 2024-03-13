//
//  NormalAlien.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class NormalEnemy: Enemy {
    static let NORMAL_ENEMY_WIDTH: CGFloat = 50.0
    static let NORMAL_ENEMY_HEIGHT: CGFloat = 50.0
    // TODO: update when adding asset
    static let imageName = ""

    init(position: CGPoint = .zero, width: CGFloat = NORMAL_ENEMY_WIDTH, height: CGFloat = NORMAL_ENEMY_HEIGHT) {
        super.init(imageName: NormalEnemy.imageName, width: width, height: height, position: position)
    }
}