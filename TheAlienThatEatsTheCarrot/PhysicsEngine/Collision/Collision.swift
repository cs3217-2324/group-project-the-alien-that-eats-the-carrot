//
//  Collision.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 14/3/24.
//

struct Collision {
    let bodyA: PhysicsBody
    let bodyB: PhysicsBody
    let collisionPoints: CollisionPoints
}

extension Collision: Hashable { }
