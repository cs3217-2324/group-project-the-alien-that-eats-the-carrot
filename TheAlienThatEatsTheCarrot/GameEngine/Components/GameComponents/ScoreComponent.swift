//
//  ScoreComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

class ScoreComponent: Component {
    var entity: Entity
    var score: Int

    init(entity: Entity, score: Int) {
        self.entity = entity
        self.score = score
    }
}
