//
//  PhysicsBody.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 14/3/24.
//

import CoreGraphics

final class PhysicsBody {
    // MARK: Physical properties
    var mass: CGFloat
    var rotation: Double
    var shape: Shape
    var size: CGSize
    var velocity: CGVector
    var restitution: CGFloat
    var position: CGPoint
    var categoryBitmask: UInt32
    var collisionBitmask: UInt32

    // MARK: Force related properties
    var isTrigger: Bool
    var isDynamic: Bool
    var forces: [CGVector]
    var netForce: CGVector {
        forces.reduce(CGVector.zero, +)
    }
    var collider: Collider {
        switch shape {
        case .circle:
            return CircleCollider(center: position, radius: size.width / 2)
        case .rectangle:
            return RectangleCollider(center: position, size: size, rotation: rotation)
        }
    }

    init(shape: Shape,
         position: CGPoint,
         size: CGSize,
         categoryBitmask: UInt32,
         collisionBitmask: UInt32,
         isDynamic: Bool,
         rotation: CGFloat = .zero,
         mass: CGFloat = 1,
         velocity: CGVector = .zero,
         forces: [CGVector] = [],
         restitution: CGFloat = PhysicsConstants.restitution,
         isTrigger: Bool = false) {
        self.shape = shape
        self.position = position
        self.size = CGSize(width: max(size.width, PhysicsConstants.physicsBodyMinimumSize),
                           height: max(size.height, PhysicsConstants.physicsBodyMinimumSize))
        self.categoryBitmask = categoryBitmask
        self.collisionBitmask = collisionBitmask
        self.rotation = rotation
        self.mass = mass
        self.velocity = velocity
        self.forces = forces
        self.restitution = restitution
        self.isDynamic = isDynamic
        self.isTrigger = isTrigger
    }

    func applyForce(_ force: CGVector) {
        forces.append(force)
    }

    func update(deltaTime: CGFloat) {
        let maxSpeed = PhysicsConstants.maxSpeed
        velocity += netForce / mass * deltaTime
        if velocity.magnitude > maxSpeed {
            velocity = velocity.unitVector * maxSpeed
        }

        let vector = velocity * deltaTime
        position += vector

        forces = []
    }
}

extension PhysicsBody: Hashable {
    static func == (lhs: PhysicsBody, rhs: PhysicsBody) -> Bool {
        lhs === rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension PhysicsBody {
    func isCollidingWith(_ other: PhysicsBody, on direction: Direction) -> Bool {
        let collisionPoints = self.collider.checkCollision(with: other.collider)
        if !collisionPoints.hasCollision {
            return false
        }
        let collisionAngle = collisionPoints.normal.angle
        var angleInDegrees = (collisionAngle * 180 / Double.pi).truncatingRemainder(dividingBy: 360)
        if (-135...(-45)).contains(angleInDegrees) {
            print("up")
        } else if (45...135).contains(angleInDegrees) {
            print("down")
        } else if (135...180).contains(angleInDegrees) || (-180...(-135)).contains(angleInDegrees) {
            print("left")
        } else if (-45...45).contains(angleInDegrees) {
            print("right")
        }
        switch direction {
        case .up:
            return (-135...(-45)).contains(angleInDegrees)
        case .down:
            return (45...135).contains(angleInDegrees)
        case .left:
            return (135...180).contains(angleInDegrees) || (-180...(-135)).contains(angleInDegrees)
        case .right:
            return (-45...45).contains(angleInDegrees)
        default:
            return false
        }
    }
}
