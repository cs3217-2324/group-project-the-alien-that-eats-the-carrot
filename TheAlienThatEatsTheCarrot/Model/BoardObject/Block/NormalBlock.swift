//
//  NormalBlock.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class NormalBlock: Block {
    // TODO: update when adding asset
    static let imageName = ""

    init(position: CGPoint = .zero) {
        super.init(imageName: NormalBlock.imageName, position: position)
    }
}
