//
//  BlockType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum BlockType {
    case normal, ground, spike, breakable, pushable, powerup

    static let blockTypeToAssetNameMap = [normal: "",
                                          ground: "",
                                          spike: "",
                                          breakable: "",
                                          pushable: "",
                                          powerup: ""]
    static let blockTypeToTypeNameMap = [normal: "normal",
                                         ground: "ground",
                                         spike: "spike",
                                         breakable: "breakable",
                                         pushable: "pushable",
                                         powerup: "powerup"]
    static let blockTypeNameToTypeMap = ["normal": normal,
                                         "ground": ground,
                                         "spike": spike,
                                         "breakable": breakable,
                                         "pushable": pushable,
                                         "powerup": powerup]
    static let blockTypeToSizeMap = [normal: CGSize(width: 50, height: 50),
                                     ground: CGSize(width: 50, height: 50),
                                     spike: CGSize(width: 50, height: 50),
                                     breakable: CGSize(width: 50, height: 50),
                                     pushable: CGSize(width: 50, height: 50),
                                     powerup: CGSize(width: 50, height: 50)]

    var assetName: String? {
        BlockType.blockTypeToAssetNameMap[self]
    }
    var width: CGFloat {
        BlockType.blockTypeToSizeMap[self]!.width
    }
    var height: CGFloat {
        BlockType.blockTypeToSizeMap[self]!.height
    }
}
