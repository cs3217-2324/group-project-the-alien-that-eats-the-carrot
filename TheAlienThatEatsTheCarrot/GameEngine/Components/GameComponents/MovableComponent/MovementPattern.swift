//
//  MovementPattern.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

protocol MovementPattern {
    func move(deltaTime: CGFloat, entity: Entity, delegate: MovableDelegate)
}
