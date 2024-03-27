//
//  EnemyType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum EnemyType: String {
    case normal,
         fast,
         stationary,
         turret

    static let typeToAssetNameMap = [normal: "snail-1",
                                     fast: "bird-1",
                                     stationary: "stationary-1",
                                     turret: "stationary-1"]
    static let typeToSizeMap = [normal: CGSize(width: 50, height: 50),
                                fast: CGSize(width: 50, height: 50),
                                stationary: CGSize(width: 50, height: 50),
                                turret: CGSize(width: 50, height: 50)]

    var assetName: String? {
        EnemyType.typeToAssetNameMap[self]
    }

    var width: CGFloat {
        EnemyType.typeToSizeMap[self]!.width
    }

    var height: CGFloat {
        EnemyType.typeToSizeMap[self]!.height
    }
}
