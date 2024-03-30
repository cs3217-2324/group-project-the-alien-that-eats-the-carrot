//
//  PowerupType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum PowerupType: String {
    case invinsible, strength, attack, doubleJump

    static let typeToAssetNameMap = [invinsible: "powerup-invincibility",
                                     strength: "powerup-strength",
                                     attack: "powerup-attack",
                                     doubleJump: "powerup-doublejump"]
    static let typeToSizeMap = [invinsible: CGSize(width: 20, height: 20),
                                strength: CGSize(width: 20, height: 20),
                                attack: CGSize(width: 20, height: 20),
                                doubleJump: CGSize(width: 20, height: 20)]

    var assetName: String? {
        PowerupType.typeToAssetNameMap[self]
    }
    
    var size: CGSize? {
        PowerupType.typeToSizeMap[self]
    }
    
    var width: CGFloat {
        PowerupType.typeToSizeMap[self]!.width
    }
    
    var height: CGFloat {
        PowerupType.typeToSizeMap[self]!.height
    }
}
