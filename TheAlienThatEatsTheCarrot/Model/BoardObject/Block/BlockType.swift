//
//  BlockType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum BlockType: String {
    case normal, ground, spike, breakable, pushable, mushroom, roller, temporary,
         doubleJumpPowerup, strengthPowerup, attackPowerup, invinciblePowerup

    static let typeToAssetNameMap = [normal: "land-top",
                                     ground: "land-bottom",
                                     spike: "spike",
                                     breakable: "block-breakable",
                                     pushable: "block-pushable",
                                     mushroom: "mushroom-1",
                                     roller: "platform-oneway",
                                     temporary: "platform-solid",
                                     doubleJumpPowerup: "powerup-unused-blue",
                                     strengthPowerup: "power-unused-yellow",
                                     attackPowerup: "powerup-unused-red",
                                     invinciblePowerup: "powerup-unused-green"]
    static let typeToSizeMap = [normal: CGSize(width: 50, height: 50),
                                ground: CGSize(width: 50, height: 50),
                                spike: CGSize(width: 50, height: 50),
                                breakable: CGSize(width: 50, height: 50),
                                mushroom: CGSize(width: 30, height: 30),
                                roller: CGSize(width: 50, height: 1),
                                temporary: CGSize(width: 50, height: 50),
                                pushable: CGSize(width: 50, height: 50),
                                doubleJumpPowerup: CGSize(width: 50, height: 50),
                                strengthPowerup: CGSize(width: 50, height: 50),
                                attackPowerup: CGSize(width: 50, height: 50),
                                invinciblePowerup: CGSize(width: 50, height: 50)
    ]

    var assetName: String? {
        BlockType.typeToAssetNameMap[self]
    }

    var size: CGSize? {
        BlockType.typeToSizeMap[self]
    }

    var width: CGFloat {
        BlockType.typeToSizeMap[self]!.width
    }
    var height: CGFloat {
        BlockType.typeToSizeMap[self]!.height
    }
}

extension BlockType: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
