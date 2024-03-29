//
//  CircleCollider.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 14/3/24.
//

import CoreGraphics

final class CircleCollider: Collider {
    var center: CGPoint
    var radius: CGFloat

    init(center: CGPoint, radius: CGFloat) {
        self.center = center
        self.radius = radius
    }

    func checkCollision(with otherCollider: Collider) -> CollisionPoints {
        otherCollider.checkCollision(with: self)
    }

    func checkCollision(with otherCollider: CircleCollider) -> CollisionPoints {
        let otherCenter = otherCollider.center
        let normal = center - otherCenter
        let pointB = otherCenter + normal.unitVector * otherCollider.radius
        let pointA = center - normal.unitVector * radius
        let hasCollision = normal.magnitude < radius + otherCollider.radius
        return CollisionPoints(hasCollision: hasCollision, pointA: pointA, pointB: pointB)
    }

    func checkCollision(with otherCollider: RectangleCollider) -> CollisionPoints {
        let otherCenter = otherCollider.center
        let rotatedCenter = center.rotated(around: otherCenter, by: -otherCollider.rotation)
        let normal = rotatedCenter - otherCenter

        let rectHalfWidth = otherCollider.size.width / 2
        let rectHalfHeight = otherCollider.size.height / 2
        let clampedX = normal.dx.clamped(-rectHalfWidth, rectHalfWidth)
        let clampedY = normal.dy.clamped(-rectHalfHeight, rectHalfHeight)
        let rotatedClosestRectPoint = otherCenter + CGVector(dx: clampedX, dy: clampedY)
        let closestRectPoint = rotatedClosestRectPoint.rotated(around: otherCenter, by: otherCollider.rotation)

        let circleCentreToRect = closestRectPoint - center
        let pointB = center + circleCentreToRect.unitVector * radius
        let hasCollision = circleCentreToRect.magnitudeSquared < radius.square()
        return CollisionPoints(hasCollision: hasCollision, pointA: closestRectPoint, pointB: pointB)
    }
}
