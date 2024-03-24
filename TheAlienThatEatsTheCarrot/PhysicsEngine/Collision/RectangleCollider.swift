//
//  RectangleCollider.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 14/3/24.
//

import CoreGraphics

final class RectangleCollider: Collider {
    var center: CGPoint
    var size: CGSize
    var rotation: Double

    init(center: CGPoint, size: CGSize, rotation: Double) {
        self.center = center
        self.size = size
        self.rotation = rotation
    }

    func checkCollision(with otherCollider: Collider) -> CollisionPoints {
        otherCollider.checkCollision(with: self)
    }

    func checkCollision(with otherCollider: CircleCollider) -> CollisionPoints {
        let collisionPoints = otherCollider.checkCollision(with: self)

        return CollisionPoints(hasCollision: collisionPoints.hasCollision,
                               pointA: collisionPoints.pointB,
                               pointB: collisionPoints.pointA)
    }

    func checkCollision(with otherCollider: RectangleCollider) -> CollisionPoints {
        let dx = abs(self.center.x - otherCollider.center.x)
        let dy = abs(self.center.y - otherCollider.center.y)
        let combinedHalfWidths = (self.size.width + otherCollider.size.width) / 2.0
        let combinedHalfHeights = (self.size.height + otherCollider.size.height) / 2.0

        if dx < combinedHalfWidths && dy < combinedHalfHeights {
            let overlapX = combinedHalfWidths - dx
            let overlapY = combinedHalfHeights - dy

            if overlapX > overlapY {
                return CollisionPoints(hasCollision: true,
                                       pointA: CGPoint(x: self.center.x, y: self.center.y - overlapY / 2),
                                       pointB: CGPoint(x: otherCollider.center.x, y: otherCollider.center.y + overlapY / 2))
            } else {
                return CollisionPoints(hasCollision: true,
                                       pointA: CGPoint(x: self.center.x - overlapX / 2, y: self.center.y),
                                       pointB: CGPoint(x: otherCollider.center.x + overlapX / 2, y: otherCollider.center.y))
            }
        } else {
            return CollisionPoints(hasCollision: false, pointA: CGPoint(), pointB: CGPoint())
        }
    }
}
