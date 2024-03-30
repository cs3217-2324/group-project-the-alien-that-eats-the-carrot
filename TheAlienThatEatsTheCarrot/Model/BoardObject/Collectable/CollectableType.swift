//
//  CollectableType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum CollectableType: String, Equatable {
    case coin, carrot, heart

    static let typeToAssetNameMap = [coin: "coin-gold",
                                     carrot: "carrot-collect",
                                     heart: "heart-full"]
    static let typeToSizeMap = [coin: CGSize(width: 50, height: 50),
                                carrot: CGSize(width: 50, height: 50),
                                heart: CGSize(width: 50, height: 50)]

    var assetName: String? {
        CollectableType.typeToAssetNameMap[self]
    }

    var size: CGSize? {
        CollectableType.typeToSizeMap[self]
    }

    var width: CGFloat {
        CollectableType.typeToSizeMap[self]!.width
    }

    var height: CGFloat {
        CollectableType.typeToSizeMap[self]!.height
    }
}
