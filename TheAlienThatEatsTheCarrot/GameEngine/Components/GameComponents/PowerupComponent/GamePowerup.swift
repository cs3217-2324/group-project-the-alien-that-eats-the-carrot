//
//  GamePowerup.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

protocol GamePowerup {
    var duration: CGFloat { get }
    var restoreAction: (() -> Void)? { get set }

    // Entity normally refers to (but is not limited to) the entity of the player
    func effectToEntity(_ entity: Entity, delegate: PowerupActionDelegate)

    func restoreDefault()
}
