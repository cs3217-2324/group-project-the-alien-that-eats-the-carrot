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

    func getEntities(withComponentTypes types: [Component.Type]) -> [Entity] {
        var resultEntities: Set<Entity> = []
        for type in types {
            let componentId = type.typeId
            if let entitiesWithComponent = componentIdToEntities[componentId] {
                resultEntities.formUnion(entitiesWithComponent)
            }
        }
        return Array(resultEntities)
    }

    func getEntity<T: Component>(with type: T.Type) -> Entity? {
        let componentId = type.typeId
        return componentIdToEntities[componentId]?.compactMap { $0 }.first
    }

    func removeEntity(_ entity: Entity) {
        guard let entityComponents = entities[entity] else {
            return
        }

        for (componentId, _) in entityComponents {
            componentIdToEntities[componentId]?.remove(entity)
            if componentIdToEntities[componentId]?.isEmpty ?? false {
                componentIdToEntities[componentId] = nil
            }
        }

        entities[entity] = nil
    }

    // MARK: Components
    func containsComponent<T: Component>(for entity: Entity, of type: T.Type) -> Bool {
        let componentId = type.typeId
        return entities[entity]?[componentId]?.first(where: { $0 is T }) != nil
    }

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

    func getComponents<T: Component>(of type: T.Type, for entity: Entity) -> [T] {
        guard
            let componentsDict = entities[entity],
            let components = componentsDict[T.typeId] as? [T]
        else {
            return []
        }

        return components
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

    func removeComponent<T: Component>(_ component: T, from entity: Entity) where T: AnyObject {
        let componentId = T.typeId
        if let index = entities[entity]?[componentId]?.firstIndex(where: { $0 as? T === component }) {
            entities[entity]?[componentId]?.remove(at: index)
            if entities[entity]?[componentId]?.isEmpty ?? true {
                componentIdToEntities[componentId]?.remove(entity)
            }
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

    func containsAnyComponent(of types: [Component.Type], in entity: Entity) -> Bool {
        for type in types {
            let componentId = type.typeId
            if let entityComponents = entities[entity], entityComponents[componentId] != nil {
                return true
            }
        }
        return false
    }
}
