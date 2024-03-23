//
//  Heart.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class Heart: Collectable {
    static let HEART_COLLECTABLE_WIDTH: CGFloat = 30.0
    static let HEART_COLLECTABLE_HEIGHT: CGFloat = 30.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .collectable(.heart)
    }

    init(position: CGPoint = .zero, width: CGFloat = Heart.HEART_COLLECTABLE_WIDTH,
         height: CGFloat = Heart.HEART_COLLECTABLE_HEIGHT) {
        super.init(imageName: Heart.imageName, width: width, height: height, position: position)
    }
}
