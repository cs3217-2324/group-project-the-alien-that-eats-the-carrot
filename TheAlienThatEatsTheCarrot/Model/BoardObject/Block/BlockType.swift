//
//  BlockType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum BlockType: String {
    case normal, ground, spike, breakable, pushable, doubleJumpPowerup

    static let typeToAssetNameMap = [normal: "land-top",
                                     ground: "land-bottom",
                                     spike: "spike",
                                     breakable: "block-breakable",
                                     pushable: "block-pushable",
                                     doubleJumpPowerup: "powerup-unused-blue"]
    static let typeToSizeMap = [normal: CGSize(width: 50, height: 50),
                                ground: CGSize(width: 50, height: 50),
                                spike: CGSize(width: 50, height: 50),
                                breakable: CGSize(width: 50, height: 50),
                                pushable: CGSize(width: 50, height: 50),
                                doubleJumpPowerup: CGSize(width: 50, height: 50)]

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
