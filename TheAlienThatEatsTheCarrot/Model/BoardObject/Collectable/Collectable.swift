//
//  Collectable.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

final class Collectable: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    var collectableType: CollectableType
    var type: ObjectType {
        .collectable(self.collectableType)
    }

    init(collectableType: CollectableType, position: CGPoint = .zero) {
        self.collectableType = collectableType
        self.position = position
        self.imageName = collectableType.assetName
        self.width = collectableType.width
        self.height = collectableType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }

    func isOverlapping(with boardObject: BoardObject) -> Bool {
        return self.position.x < boardObject.position.x + boardObject.width &&
            self.position.x + self.width > boardObject.position.x &&
            self.position.y < boardObject.position.y + boardObject.height &&
            self.position.y + self.height > boardObject.position.y
    }
}

extension Collectable: Hashable {
    public static func == (lhs: Collectable, rhs: Collectable) -> Bool {
        lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
