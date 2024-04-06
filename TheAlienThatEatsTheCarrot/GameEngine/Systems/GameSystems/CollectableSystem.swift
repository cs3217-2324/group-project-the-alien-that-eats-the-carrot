//
//  CollectableSystem.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class CollectableSystem: System {
    var nexus: Nexus

    init(nexus: Nexus) {
        self.nexus = nexus
    }

    func update(deltaTime: CGFloat) {
        let collectableComponents = nexus.getComponents(of: CollectableComponent.self)
        let playerComponents = nexus.getComponents(of: PlayerComponent.self)
        for collectableComponent in collectableComponents {
            for playerComponent in playerComponents {
                guard
                    let collectableRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: collectableComponent.entity),
                    let playerRenderableComponent = nexus.getComponent(of: RenderableComponent.self, for: playerComponent.entity) else {
                    continue
                }
                if playerRenderableComponent.overlapsWith(collectableRenderableComponent) {
                    collectableComponent.collectCollectableForEntity(playerComponent.entity, delegate: self)
                    nexus.removeComponent(collectableRenderableComponent, from: collectableComponent.entity)
                }
            }
        }
    }
}

extension CollectableSystem: CollectableActionDelegate {
    func getComponent<T>(of type: T.Type, for entity: Entity) -> T? where T: Component {
        nexus.getComponent(of: type, for: entity)
    }
}
