//
//  AttackableDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol AttackableDelegate {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T?

    func removeComponent<T: Component>(_ component: T, from entity: Entity) where T: AnyObject
}
