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

    init(entity: Entity, powerup: GamePowerup) {
        self.entity = entity
        self.powerup = powerup
    }

    func activatePowerupForEntity(_ entity: Entity, delegate: PowerupActionDelegate) {
        powerup.effectToEntity(entity, delegate: delegate)
    }
}
