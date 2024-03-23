//
//  CollectableType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum CollectableType: Equatable {
    case coin, carrot, heart

    static let collectableTypeToAssetNameMap = [coin: "",
                                                carrot: "",
                                                heart: ""]
    static let collectableTypeToTypeNameMap = [coin: "coin",
                                               carrot: "carrot",
                                               heart: "heart"]
    static let collectableTypeNameToTypeMap = ["coin": coin,
                                               "carrot": carrot,
                                               "heart": heart]
    static let collectableTypeToSizeMap = [coin: CGSize(width: 20, height: 20),
                                           carrot: CGSize(width: 20, height: 20),
                                           heart: CGSize(width: 20, height: 20)]

    var assetName: String? {
        CollectableType.collectableTypeToTypeNameMap[self]
    }
    var width: CGFloat {
        CollectableType.collectableTypeToSizeMap[self]!.width
    }
    var height: CGFloat {
        CollectableType.collectableTypeToSizeMap[self]!.height
    }
}
