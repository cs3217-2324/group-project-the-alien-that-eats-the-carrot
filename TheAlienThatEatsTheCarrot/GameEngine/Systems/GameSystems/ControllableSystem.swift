//
//  ControllableSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class ControllableSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let comtrollableComponents = nexus.getComponents(of: ControllableComponent.self)
        for controllable in comtrollableComponents {
            applyPhysicsBasedOnControlAction(for: controllable)
        }
    }

    private func applyPhysicsBasedOnControlAction(for controllable: ControllableComponent) {
        switch controllable.action {
        case .idle:
            print("Do nothing")
        case .jump:
            print("Apply upward force to player entity")
        case .left:
            print("Apply leftward velocity")
        case .right:
            print("Apply rightward velocity")
        }
    }
}
