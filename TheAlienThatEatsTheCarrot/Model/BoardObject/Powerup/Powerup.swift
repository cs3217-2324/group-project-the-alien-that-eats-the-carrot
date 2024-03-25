//
//  Powerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

final class Powerup: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    var powerupType: PowerupType
    var type: ObjectType {
        .powerup(self.powerupType)
    }

    init(powerupType: PowerupType, position: CGPoint = .zero) {
        self.powerupType = powerupType
        self.position = position
        self.imageName = powerupType.assetName
        self.width = powerupType.width
        self.height = powerupType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }

    func isOverlapping(with boardObject: BoardObject) -> Bool {
        return boardObject.isOverlapping(with: self)
    }
}

extension Powerup: Hashable {
    public static func == (lhs: Powerup, rhs: Powerup) -> Bool {
        lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
