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
        subscribeToEvents()
    }

    func update(deltaTime: CGFloat) {
        removeAllIsInCameraComponents()
        updateIsInCamera(deltaTime: deltaTime)
    }

    func subscribeToEvents() {
        let gameStartObserver = EventManager.shared.subscribe(to: GameStartEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        print("B Receiving event! \(event.self)")
    }

    private func removeAllIsInCameraComponents() {
        // TODO: Reset toRender in camera components
    }

    private func updateIsInCamera(deltaTime: CGFloat) {
        let playerEntities = nexus.getEntities(with: PlayerComponent.self)

        let entities = nexus.getEntities(with: RenderableComponent.self)
        for entity in entities {
            guard let renderableComponent = nexus.getComponent(of: RenderableComponent.self, for: entity) else {
                continue
            }
            for player in playerEntities {
                addObjectToCameraIfIsWithinBound(object: renderableComponent, player: player)
            }
        }
    }

    private func addObjectToCameraIfIsWithinBound(object: RenderableComponent, player: Entity) {
        guard let cameraComponent = nexus.getComponent(of: CameraComponent.self, for: player) else {
            return
        }
        if isObjectWithinBound(position: object.position, size: object.size,
                               bound: cameraComponent.cameraBounds) {
            cameraComponent.toRender.append(object)
        }
    }

    private func isObjectWithinBound(position: CGPoint, size: CGSize, bound: CGRect) -> Bool {
        let objectRect = CGRect(origin: position, size: size)
        return bound.intersects(objectRect)
    }
}
