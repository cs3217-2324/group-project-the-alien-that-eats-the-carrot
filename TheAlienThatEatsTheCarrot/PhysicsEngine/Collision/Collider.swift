//
//  Collider.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 14/3/24.
//

protocol Collider {
    func checkCollision(with otherCollider: Collider) -> CollisionPoints
    func checkCollision(with otherCollider: CircleCollider) -> CollisionPoints
    func checkCollision(with otherCollider: RectangleCollider) -> CollisionPoints
}
