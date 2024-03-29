//
//  PowerupActionDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

protocol PowerupActionDelegate: AnyObject {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T?

    func addComponent<T: Component>(_ component: T, to entity: Entity)
}
