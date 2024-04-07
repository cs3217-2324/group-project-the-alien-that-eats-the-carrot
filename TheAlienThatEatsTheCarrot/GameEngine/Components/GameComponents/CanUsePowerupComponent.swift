//
//  CanUsePowerupComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 7/4/24.
//

import Foundation

class CanUsePowerupComponent: Component {
    static let ALL_POWERUPS: [PowerupType] = Array(PowerupType.allCases)
    var entity: Entity
    var canUse: [PowerupType]

    init(entity: Entity, canUse: [PowerupType] = CanUsePowerupComponent.ALL_POWERUPS) {
        self.entity = entity
        self.canUse = canUse
    }

    func canUse(_ powerupType: PowerupType) -> Bool {
        canUse.contains(powerupType)
    }
}
