//
//  NormalAlien.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

class NormalCharacter: Character {
    static let NORMAL_CHARACTER_WIDTH = 50.0
    static let NORMAL_CHARACTER_HEIGHT = 50.0
    // TODO: update when adding asset
    static let imageName = ""
    override var type: ObjectType {
        .character(.normal)
    }

    init(position: CGPoint = .zero, width: CGFloat = NORMAL_CHARACTER_WIDTH, height: CGFloat = NORMAL_CHARACTER_HEIGHT) {
        super.init(imageName: NormalCharacter.imageName, width: width, height: height, position: position)
    }
}
