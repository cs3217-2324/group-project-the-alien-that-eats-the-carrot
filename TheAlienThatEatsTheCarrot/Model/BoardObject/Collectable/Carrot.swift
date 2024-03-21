//
//  Carrot.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class Carrot: Collectable {
    static let CARROT_COLLECTABLE_WIDTH: CGFloat = 30.0
    static let CARROT_COLLECTABLE_HEIGHT: CGFloat = 30.0
    // TODO: update when adding asset
    static let imageName = ""
    static let type = ObjectType.CollectableType.carrot

    init(position: CGPoint = .zero, width: CGFloat = Carrot.CARROT_COLLECTABLE_WIDTH, height: CGFloat = Carrot.CARROT_COLLECTABLE_HEIGHT) {
        super.init(imageName: Carrot.imageName, width: width, height: height, position: position)
    }
}
