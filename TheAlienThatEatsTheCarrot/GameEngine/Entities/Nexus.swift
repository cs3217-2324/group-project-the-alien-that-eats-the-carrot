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
}
