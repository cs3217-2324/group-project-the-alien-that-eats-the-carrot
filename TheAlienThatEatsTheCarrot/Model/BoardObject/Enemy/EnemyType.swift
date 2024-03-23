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

    static let enemyTypeToAssetNameMap = [normal: "",
                                            fast: "",
                                      stationary: "",
                                          turret: ""]
    
    static let enemyTypeToTypeNameMap = [normal: "normal",
                                           fast: "fast",
                                     stationary: "stationary",
                                         turret: "turret"]
    
    static let enemyTypeNameToTypeMap = ["normal": normal,
                                         "fast": fast,
                                         "stationary": stationary,
                                         "turret": turret]
    
    static let enemyTypeToSizeMap = [normal: CGSize(width: 50, height: 50),
                                       fast: CGSize(width: 50, height: 50),
                                 stationary: CGSize(width: 50, height: 50),
                                     turret: CGSize(width: 50, height: 50)]
    var assetName: String? {
        EnemyType.enemyTypeToAssetNameMap[self]
    }
    
    var width: CGFloat {
        EnemyType.enemyTypeToSizeMap[self]!.width
    }

    var height: CGFloat {
        EnemyType.enemyTypeToSizeMap[self]!.height
    }
}
