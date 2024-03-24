//
//  EnemyType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum EnemyType {
    case normal,
         fast,
         stationary,
         turret

    static let typeToAssetNameMap = [normal: "",
                                     fast: "",
                                     stationary: "",
                                     turret: ""]
    static let typeToTypeNameMap = [normal: "normal",
                                    fast: "fast",
                                    stationary: "stationary",
                                    turret: "turret"]
    static let typeNameToTypeMap = ["normal": normal,
                                    "fast": fast,
                                    "stationary": stationary,
                                    "turret": turret]
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
