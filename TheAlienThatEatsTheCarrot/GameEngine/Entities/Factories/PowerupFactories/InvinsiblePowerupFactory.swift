//
//  InvinsiblePowerupFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class InvinsiblePowerupFactory: PowerupFactory {
    override func createComponents() -> [Component] {
        let powerupComponent = PowerupComponent(entity: entity, powerup: InvinsibleGamePowerup())
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .powerup(.invinsible))
        return [powerupComponent, renderableComponent]
    }
}
