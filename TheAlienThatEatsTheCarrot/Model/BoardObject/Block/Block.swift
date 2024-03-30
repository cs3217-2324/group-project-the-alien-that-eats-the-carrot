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
        
        let minX1 = position.x - width / 2
        let maxX1 = position.x + width / 2
        let minY1 = position.y - height / 2
        let maxY1 = position.y + height / 2
        
        let minX2 = boardObject.position.x - boardObject.width / 2
        let maxX2 = boardObject.position.x + boardObject.width / 2
        let minY2 = boardObject.position.y - boardObject.height / 2
        let maxY2 = boardObject.position.y + boardObject.height / 2
        
        return minX1 < maxX2 && maxX1 > minX2 && minY1 < maxY2 && maxY1 > minY2
    }
    
    func contains(point: CGPoint) -> Bool {
        let minX = position.x - width / 2
        let maxX = position.x + width / 2
        let minY = position.y - height / 2
        let maxY = position.y + height / 2
        return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY
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
