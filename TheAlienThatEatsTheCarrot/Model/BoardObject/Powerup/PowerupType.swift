//
//  PowerupType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum PowerupType {
    case invinsible, strength, attack, doubleJump

    static let powerupTypeToAssetNameMap = [invinsible: "",
                                          strength: "",
                                            attack: "",
                                        doubleJump: ""]
    static let powerupTypeToTypeNameMap = [invinsible: "invinsible",
                                             strength: "strength",
                                               attack: "attack",
                                           doubleJump: "doubleJump"]
    static let powerupTypeNameToTypeMap = ["invinsible": invinsible,
                                           "strength": strength,
                                           "attack": attack,
                                           "doubleJump": doubleJump]
    static let powerupTypeToSizeMap = [invinsible: CGSize(width: 20, height: 20),
                                         strength: CGSize(width: 20, height: 20),
                                           attack: CGSize(width: 20, height: 20),
                                       doubleJump: CGSize(width: 20, height: 20)]

    var assetName: String? {
        PowerupType.powerupTypeToAssetNameMap[self]
    }
    var width: CGFloat {
        PowerupType.powerupTypeToSizeMap[self]!.width
    }
    var height: CGFloat {
        PowerupType.powerupTypeToSizeMap[self]!.height
    }
}
