//
//  GameObject.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

// TODO: merged to GameObject in Component of ECS
protocol BoardObject: AnyObject & Hashable {
    var position: CGPoint { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var imageName: String? { get set }
    var type: ObjectType { get }

    // TODO: remove when ECS is implemented
    func move(to newPosition: CGPoint)
    func hash(into hasher: inout Hasher)
}

extension BoardObject {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.position)
        hasher.combine(self.width)
        hasher.combine(self.height)
    }
}
