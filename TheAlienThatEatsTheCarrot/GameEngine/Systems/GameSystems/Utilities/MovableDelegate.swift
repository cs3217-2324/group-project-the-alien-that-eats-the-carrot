//
//  MovableDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol MovableDelegate: AnyObject {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T?

    func getComponents<T: Component>(of type: T.Type) -> [T]
    func containsAnyComponent(of types: [Component.Type], in entity: Entity) -> Bool
}
