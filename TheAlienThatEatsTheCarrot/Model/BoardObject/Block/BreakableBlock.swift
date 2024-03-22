//
//  BreakableBlock.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class BreakableBlock: Block {
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .block(.breakable)
    }

    init(position: CGPoint = .zero) {
        super.init(imageName: BreakableBlock.imageName, position: position)
    }
}
