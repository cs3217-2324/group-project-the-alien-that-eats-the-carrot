//
//  PhysicsCollisionDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 2/4/24.
//

protocol PhysicsCollisionDelegate: AnyObject {
    func didBegin(_ collision: Collision)
    func didEnd(_ collision: Collision)
}
