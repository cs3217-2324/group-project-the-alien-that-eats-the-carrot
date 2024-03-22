//
//  Coin.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class Coin: Collectable {
    static let COIN_COLLECTABLE_WIDTH: CGFloat = 30.0
    static let COIN_COLLECTABLE_HEIGHT: CGFloat = 30.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .collectable(.coin)
    }

    init(position: CGPoint = .zero, width: CGFloat = Coin.COIN_COLLECTABLE_WIDTH,
         height: CGFloat = Coin.COIN_COLLECTABLE_HEIGHT) {
        super.init(imageName: Coin.imageName, width: width, height: height, position: position)
    }
}
