//
//  Collectable.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

final class Collectable: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    var collectableType: CollectableType
    var type: ObjectType {
        .collectable(self.collectableType)
    }

    init(collectableType: CollectableType, position: CGPoint = .zero) {
        self.collectableType = collectableType
        self.position = position
        self.imageName = collectableType.assetName
        self.width = collectableType.width
        self.height = collectableType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
