//
//  InventoryComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

class InventoryComponent: Component {
    var entity: Entity
    var carrotCount: Int
    var coinCount: Int

    init(entity: Entity, carrotCount: Int = 0, coinCount: Int = 0) {
        self.entity = entity
        self.carrotCount = carrotCount
        self.coinCount = coinCount
    }

    func incrementCarrot() {
        carrotCount += 1
    }

    func incrementCoin() {
        coinCount += 1
    }
}
