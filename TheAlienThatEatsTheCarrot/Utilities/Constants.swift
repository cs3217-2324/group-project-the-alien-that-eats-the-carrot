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
    static let characterCategoryBitmask: UInt32 = 1 << 0
    static let enemyCategoryBitmask: UInt32 = 1 << 1
    static let blockCategoryBitmask: UInt32 = 1 << 2
    static let powerupCategoryBitmask: UInt32 = 1 << 3
    static let collectableCategoryBitmask: UInt32 = 1 << 4
    static let projectileCategoryBitmask: UInt32 = 1 << 5

    // Collision Bitmasks
    static let characterCollisionBitmask: UInt32 = enemyCategoryBitmask | blockCategoryBitmask
    static let enemyCollisionBitmask: UInt32 = characterCategoryBitmask | blockCategoryBitmask
    static let blockCollisionBitmask: UInt32 = characterCategoryBitmask | blockCategoryBitmask | enemyCategoryBitmask
    static let powerupCollisionBitmask: UInt32 = 0
    static let collectibleCollisionBitmask: UInt32 = 0
    static let projectileCollisionBitmask: UInt32 = characterCategoryBitmask | blockCategoryBitmask
}
