//
//  StationaryEnemyFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 29/3/24.
//

import Foundation

class StationaryEnemyFactory: EnemyFactory {
    static let SCORE = 200.0
    override func createComponents() -> [Component] {
        let enemyComponent = EnemyComponent(entity: entity)
        let renderableComponent = RenderableComponent(entity: entity, position: boardObject.position, objectType: .enemy(.normal))
        let movableComponent = MovableComponent(entity: entity)
        let destroyableComponent = DestroyableComponent(entity: entity)
        let scoreComponent = ScoreComponent(entity: entity, score: StationaryEnemyFactory.SCORE)
        return [enemyComponent, renderableComponent, movableComponent, destroyableComponent, scoreComponent]
    }
}
