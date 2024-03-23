//
//  Enemy.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

final class Enemy: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    var enemyType: EnemyType
    var type: ObjectType {
        .enemy(self.enemyType)
    }

    init(enemyType: EnemyType, position: CGPoint = .zero) {
        self.enemyType = enemyType
        self.position = position
        self.imageName = enemyType.assetName
        self.width = enemyType.width
        self.height = enemyType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
