//
//  Character.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import Foundation

class Character: BoardObject {
    var position: CGPoint = .zero
    var width: CGFloat
    var height: CGFloat

    init(position: CGPoint = .zero, width: CGFloat = 50.0, height: CGFloat = 100.0) {
        self.position = position
        self.width = width
        self.height = height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }
}
