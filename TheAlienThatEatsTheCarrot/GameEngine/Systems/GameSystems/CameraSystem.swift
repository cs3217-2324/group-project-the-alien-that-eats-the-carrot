//
//  CameraSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 23/3/24.
//

import Foundation

class CameraSystem: System {
    var nexus: Nexus
    
    init(nexus: Nexus) {
        self.nexus = nexus
    }
    
    func update(deltaTime: CGFloat) {
        updateRenderableEntitiesForPlayerA(deltaTime: deltaTime)
        updateRenderableEntitiesForPlayerB(deltaTime: deltaTime)
    }
    
    private func updateRenderableEntitiesForPlayerA(deltaTime: CGFloat) {
        guard let playerAEntity = nexus.getEntity(with: PlayerAComponent.self) else {
            return
        }
        let cameraA = nexus.getComponent(of: CameraComponent.self, for: playerAEntity)
        let entities = nexus.getEntities(with: RenderableComponent.self)
    }
    
    private func updateRenderableEntitiesForPlayerB(deltaTime: CGFloat) {
    }
}
