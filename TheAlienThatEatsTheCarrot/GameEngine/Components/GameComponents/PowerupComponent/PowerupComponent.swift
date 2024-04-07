//
//  PowerupComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

class PowerupComponent: Component {
    var entity: Entity
    var powerup: GamePowerup
    var powerupType: PowerupType

    init(entity: Entity, powerup: GamePowerup, powerupType: PowerupType) {
        self.entity = entity
        self.powerup = powerup
        self.powerupType = powerupType
    }

    func activatePowerupForEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
        powerup.effectToEntity(entity, delegate: delegate)
    }
}
