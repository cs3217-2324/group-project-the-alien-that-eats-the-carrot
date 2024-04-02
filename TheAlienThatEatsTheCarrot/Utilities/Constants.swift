//
//  Constants.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 2/4/24.
//

import CoreGraphics

struct Constants {
    // Rendering
    static let framesPerSecond: Int = 60

    // Category Bitmasks
    static let playerCategoryBitmask: UInt32 = 1 << 0
    static let enemyCategoryBitmask: UInt32 = 1 << 1
    static let wallCategoryBitmask: UInt32 = 1 << 2

    // Collision Bitmasks
    static let playerCollisionBitmask: UInt32 = enemyCategoryBitmask | wallCategoryBitmask
    static let enemyCollisionBitmask: UInt32 = playerCategoryBitmask
    static let wallCollisionBitmask: UInt32 = playerCategoryBitmask
}
