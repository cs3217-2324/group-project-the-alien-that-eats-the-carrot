//
//  StrengthPowerupFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class StrengthPowerupFactory: PowerupFactory {
    override func createComponents() -> [Component] {
        let powerupComponent = PowerupComponent(entity: entity, powerup: StrengthGamePowerup())
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .powerup(.strength))
        return [powerupComponent, renderableComponent]
    }
}
