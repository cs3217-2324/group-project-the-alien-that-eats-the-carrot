//
//  Entity.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

final class Entity {
}

extension Entity: Hashable {
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        let hashValue = ObjectIdentifier(self).hashValue
        hasher.combine(hashValue)
    }
}
