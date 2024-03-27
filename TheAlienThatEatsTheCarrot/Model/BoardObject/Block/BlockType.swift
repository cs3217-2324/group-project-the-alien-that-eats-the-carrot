//
//  BlockType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum BlockType: String {
    case normal, ground, spike, breakable, pushable, powerup

    static let typeToAssetNameMap = [normal: "land-top",
                                     ground: "land-bottom",
                                     spike: "spike",
                                     breakable: "block-breakable",
                                     pushable: "block-pushable",
                                     powerup: "powerup-unused"]
    static let typeToSizeMap = [normal: CGSize(width: 50, height: 50),
                                ground: CGSize(width: 50, height: 50),
                                spike: CGSize(width: 50, height: 50),
                                breakable: CGSize(width: 50, height: 50),
                                pushable: CGSize(width: 50, height: 50),
                                powerup: CGSize(width: 50, height: 50)]

    var assetName: String? {
        BlockType.typeToAssetNameMap[self]
    }
    var width: CGFloat {
        BlockType.typeToSizeMap[self]!.width
    }
    var height: CGFloat {
        BlockType.typeToSizeMap[self]!.height
    }
}
