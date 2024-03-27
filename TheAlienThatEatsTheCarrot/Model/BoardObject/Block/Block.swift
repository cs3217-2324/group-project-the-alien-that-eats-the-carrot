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

    func isOverlapping(with boardObject: BoardObject) -> Bool {
        if boardObject is Powerup && self.blockType == .powerup {
            return false
        }
        return self.position.x < boardObject.position.x + boardObject.width &&
            self.position.x + self.width > boardObject.position.x &&
            self.position.y < boardObject.position.y + boardObject.height &&
            self.position.y + self.height > boardObject.position.y
    }
}

extension Block: Hashable {
    public static func == (lhs: Block, rhs: Block) -> Bool {
        lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
