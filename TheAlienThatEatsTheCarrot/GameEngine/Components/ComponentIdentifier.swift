//
//  ComponentIdentifier.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

struct ComponentIdentifier: Hashable {
    private let id: Int

    init<T: Component>(_ componentType: T.Type) {
        self.id = ObjectIdentifier(componentType).hashValue
    }
}
