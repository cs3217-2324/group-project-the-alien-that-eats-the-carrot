//
//  ProjectileType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

public enum ProjectileType: String {
    case pellet

    static let typeToAssetNameMap = [pellet: "projectile-pellet"]
    static let typeToSizeMap = [pellet: CGSize(width: 3, height: 3)]

    var assetName: String? {
        ProjectileType.typeToAssetNameMap[self]
    }

    var size: CGSize? {
        ProjectileType.typeToSizeMap[self]
    }

    var width: CGFloat {
        ProjectileType.typeToSizeMap[self]!.width
    }

    var height: CGFloat {
        ProjectileType.typeToSizeMap[self]!.height
    }
}
