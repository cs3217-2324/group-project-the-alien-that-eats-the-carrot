//
//  Block.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

final class Block: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    var blockType: BlockType
    var containedPowerupType: PowerupType?
    var type: ObjectType {
        .block(self.blockType)
    }

    init(blockType: BlockType,
         containedPowerupType: PowerupType?,
         position: CGPoint = .zero) {
        self.blockType = blockType
        self.position = position
        self.containedPowerupType = containedPowerupType
        self.imageName = blockType.assetName
        self.width = blockType.width
        self.height = blockType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
