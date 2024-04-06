//
//  CollisionEffectDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 6/4/24.
//

import Foundation

protocol CollisionEffectDelegate {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T?
    func containsAnyComponent(of types: [Component.Type], in entity: Entity) -> Bool
}
