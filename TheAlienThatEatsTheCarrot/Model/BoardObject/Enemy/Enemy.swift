//
//  Enemy.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import Foundation

class Enemy: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat
    var imageName: String?

    init(imageName: String, position: CGPoint = .zero, width: CGFloat = 50.0, height: CGFloat = 100.0) {
        self.imageName = imageName
        self.position = position
        self.width = width
        self.height = height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
