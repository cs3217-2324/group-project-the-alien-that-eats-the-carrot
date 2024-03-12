//
//  GameObject.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

// TODO: merged to GameObject in Component of ECS
protocol BoardObject {
    var position: CGPoint { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }

    func move(to newPosition: CGPoint)
}
