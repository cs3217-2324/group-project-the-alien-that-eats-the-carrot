//
//  CollectableActionDelegate.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol CollectableActionDelegate: AnyObject {
    func getComponent<T: Component>(of type: T.Type, for entity: Entity) -> T?
}
