//
//  Nexus.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

final class Nexus {
    private var entities: [Entity: [ComponentIdentifier: [Component]]] = [:]
    private var componentIdToEntities: [ComponentIdentifier: Set<Entity>] = [:]

    // MARK: Entities
    func getEntities<T: Component>(with type: T.Type) -> [Entity] {
        let componentId = type.typeId
        return componentIdToEntities[componentId]?.compactMap { $0 } ?? []
    }
    
    func getEntity<T: Component>(with type: T.Type) -> Entity? {
        let componentId = type.typeId
        return componentIdToEntities[componentId]?.compactMap { $0 }.first
    }

    // MARK: Components
    func getComponents<T: Component>(of type: T.Type) -> [T] {
        var components = [T]()
        for entityComponents in entities.values {
            if let comps = entityComponents[type.typeId] as? [T] {
                components.append(contentsOf: comps)
            }
        }
        return components
    }

    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T? {
        let componentId = type.typeId
        return entities[entity]?[componentId]?.compactMap { $0 as? T }.first
    }

    func addComponent<T: Component>(_ component: T, to entity: Entity) {
        let componentId = type(of: component).typeId
        entities[entity, default: [:]][componentId, default: []].append(component)
        componentIdToEntities[componentId, default: Set<Entity>()].insert(entity)
    }

    func addComponents(_ components: [Component], to entity: Entity) {
        for component in components {
            addComponent(component, to: entity)
        }
    }

    func removeComponents<T: Component>(of type: T.Type) {
        let componentId = type.typeId
        entities.keys.forEach { entity in
            entities[entity]?[componentId]?.removeAll()
        }
        componentIdToEntities[componentId]?.removeAll()
    }

    func removeComponents<T: Component>(of type: T.Type, for entity: Entity) {
        if entities[entity] == nil {
            return
        }
        let componentId = type.typeId
        entities[entity]?[componentId]?.removeAll()
        componentIdToEntities[componentId]?.remove(entity)
    }
}
