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
    var imageName: String?
    var characterType: CharacterType
    var type: ObjectType {
        .character(self.characterType)
    }

    init(characterType: CharacterType, position: CGPoint = .zero) {
        self.characterType = characterType
        self.position = position
        self.imageName = characterType.assetName
        self.width = characterType.width
        self.height = characterType.height
    }

    func move(to newPosition: CGPoint) {
        self.position = newPosition
    }

    func isOverlapping(with boardObject: BoardObject) -> Bool {
        self.position.x < boardObject.position.x + boardObject.width &&
            self.position.x + self.width > boardObject.position.x &&
            self.position.y < boardObject.position.y + boardObject.height &&
            self.position.y + self.height > boardObject.position.y
    }
}
