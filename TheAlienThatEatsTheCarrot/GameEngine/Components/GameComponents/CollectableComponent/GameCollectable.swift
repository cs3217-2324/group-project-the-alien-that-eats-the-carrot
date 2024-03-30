//
//  GameCollectable.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol GameCollectable {
    func effectToEntity(_ entity: Entity, delegate: CollectableActionDelegate)
}
