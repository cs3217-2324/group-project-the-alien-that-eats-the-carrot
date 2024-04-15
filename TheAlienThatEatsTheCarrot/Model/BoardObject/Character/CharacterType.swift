//
//  CharacterType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum CharacterType: String {
    case normal

    static let typeToAssetNameMap = [normal: "alien-1"]
    static let typeToSizeMap = [normal: CGSize(width: 5, height: 5)]

    var assetName: String? {
        CharacterType.typeToAssetNameMap[self]
    }

    var size: CGSize? {
        CharacterType.typeToSizeMap[self]
    }

    var width: CGFloat {
        CharacterType.typeToSizeMap[self]!.width
    }

    var height: CGFloat {
        CharacterType.typeToSizeMap[self]!.height
    }
}
