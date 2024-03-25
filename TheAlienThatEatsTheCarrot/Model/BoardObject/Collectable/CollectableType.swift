//
//  CollectableType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum CollectableType: Equatable {
    case coin, carrot, heart

    static let typeToAssetNameMap = [coin: "coin-gold",
                                     carrot: "carrot-collect",
                                     heart: "heart-full"]
    static let typeToTypeNameMap = [coin: "coin",
                                    carrot: "carrot",
                                    heart: "heart"]
    static let typeNameToTypeMap = ["coin": coin,
                                    "carrot": carrot,
                                    "heart": heart]
    static let typeToSizeMap = [coin: CGSize(width: 20, height: 20),
                                carrot: CGSize(width: 20, height: 20),
                                heart: CGSize(width: 20, height: 20)]

    var assetName: String? {
        CollectableType.typeToTypeNameMap[self]
    }
    var width: CGFloat {
        CollectableType.typeToSizeMap[self]!.width
    }
    var height: CGFloat {
        CollectableType.typeToSizeMap[self]!.height
    }
}
