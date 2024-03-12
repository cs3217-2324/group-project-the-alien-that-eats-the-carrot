//
//  NormalBlock.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class NormalBlock: Block {
    static let NORMAL_BLOCK_WIDTH: CGFloat = 50.0
    static let NORMAL_BLOCK_HEIGHT: CGFloat = 50.0
    // TODO: update when adding asset
    static let imageName = ""

    init(position: CGPoint = .zero, width: CGFloat = NORMAL_BLOCK_WIDTH, height: CGFloat = NORMAL_BLOCK_HEIGHT) {
        super.init(imageName: NormalBlock.imageName, position: position, width: width, height: height)
    }
}
