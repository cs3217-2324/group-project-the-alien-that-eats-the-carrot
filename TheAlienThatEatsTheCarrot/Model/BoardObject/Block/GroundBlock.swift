//
//  GroundBlock.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class GroundBlock: Block {
    // TODO: update when adding asset
    static let imageName = ""
    static let type = ObjectType.BlockType.ground

    init(position: CGPoint = .zero) {
        super.init(imageName: GroundBlock.imageName, position: position)
    }
}
