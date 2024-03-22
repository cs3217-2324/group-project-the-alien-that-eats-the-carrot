//
//  Block.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class Block: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?
    static let DEFAULT_BLOCK_WIDTH: CGFloat = 50.0
    static let DEFAULT_BLOCK_HEIGHT: CGFloat = 50.0
    var type: ObjectType {
        .block(.normal)
    }


    init(imageName: String, position: CGPoint = .zero, width: CGFloat = Block.DEFAULT_BLOCK_WIDTH, height: CGFloat = Block.DEFAULT_BLOCK_HEIGHT) {
        self.imageName = imageName
        self.position = position
        self.width = width
        self.height = height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
