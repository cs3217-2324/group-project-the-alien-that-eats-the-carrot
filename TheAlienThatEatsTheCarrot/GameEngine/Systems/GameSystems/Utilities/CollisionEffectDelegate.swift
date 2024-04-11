//
//  CollisionEffectDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

protocol CollisionEffectDelegate {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T?
    func getComponents<T: Component>(of type: T.Type) -> [T]
    func addComponent<T: Component>(_ component: T, to entity: Entity)
    func containsAnyComponent(of types: [Component.Type], in entity: Entity) -> Bool
    func removeComponents<T: Component>(of type: T.Type, for entity: Entity)
}
