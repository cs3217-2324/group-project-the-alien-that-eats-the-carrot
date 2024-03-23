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
        removeAllIsInCameraComponents()
        updateIsInPlayerACameraEntities(deltaTime: deltaTime)
        updateIsInPlayerBCameraEntities(deltaTime: deltaTime)
    }

    private func removeAllIsInCameraComponents() {
        nexus.removeComponents(of: IsInPlayerACameraComponent.self)
        nexus.removeComponents(of: IsInPlayerBCameraComponent.self)
    }

    private func updateIsInPlayerACameraEntities(deltaTime: CGFloat) {
        guard let playerAEntity = nexus.getEntity(with: PlayerAComponent.self),
              let cameraAComponent = nexus.getComponent(of: CameraComponent.self, for: playerAEntity) else {
            return
        }
        let entities = nexus.getEntities(with: RenderableComponent.self)
        for entity in entities {
            guard let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: entity) else {
                continue
            }
            if isObjectWithinBound(position: renderableComponent.position, size: renderableComponent.size, bound: cameraAComponent.cameraBounds) {
                let isInPlayerACameraComponent = IsInPlayerACameraComponent(entity: entity)
                nexus.addComponent(isInPlayerACameraComponent, to: entity)
            }
        }
    }

    private func updateIsInPlayerBCameraEntities(deltaTime: CGFloat) {
    }

    private func isObjectWithinBound(position: CGPoint, size: CGSize, bound: CGRect) -> Bool {
        let objectRect = CGRect(origin: position, size: size)
        return bound.intersects(objectRect)
    }
}
