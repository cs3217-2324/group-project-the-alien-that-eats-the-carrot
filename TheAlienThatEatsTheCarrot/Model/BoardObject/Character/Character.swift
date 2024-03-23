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

    public static func == (lhs: Character, rhs: Character) -> Bool {
        lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
