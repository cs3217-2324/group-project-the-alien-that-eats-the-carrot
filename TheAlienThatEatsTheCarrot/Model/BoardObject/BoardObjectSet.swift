//
//  BoardObjectSet.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

struct BoardObjectSet {
    var blocks: Set<Block>
    var collectables: Set<Collectable>
    var enemies: Set<Enemy>
    var powerups: Set<Powerup>
    var allObjects: [any BoardObject] {
        Array(blocks) + Array(collectables) + Array(enemies) + Array(powerups)
    }

    init(blocks: Set<Block> = Set(),
         collectables: Set<Collectable> = Set(),
         enemies: Set<Enemy> = Set(),
         powerups: Set<Powerup> = Set()) {
        self.blocks = blocks
        self.collectables = collectables
        self.enemies = enemies
        self.powerups = powerups
    }

    mutating func add(boardObject: any BoardObject) {
        for existingBoardObject in self.allObjects where existingBoardObject.isOverlapping(with: boardObject) {
            return
        }
        if let block = boardObject as? Block {
            blocks.insert(block)
        }
        if let collectable = boardObject as? Collectable {
            collectables.insert(collectable)
        }
        if let enemy = boardObject as? Enemy {
            enemies.insert(enemy)
        }
        if let powerup = boardObject as? Powerup {
            powerups.insert(powerup)
        }
    }

    func canAdd(boardObject: any BoardObject) -> Bool {
        for existingBoardObject in self.allObjects where existingBoardObject.isOverlapping(with: boardObject) {
            return false
        }
        return true
    }

    mutating func remove(boardObject: any BoardObject) {
        if let block = boardObject as? Block {
            blocks.remove(block)
        }
        if let collectable = boardObject as? Collectable {
            collectables.remove(collectable)
        }
        if let enemy = boardObject as? Enemy {
            enemies.remove(enemy)
        }
        if let powerup = boardObject as? Powerup {
            powerups.remove(powerup)
        }
    }

    mutating func scale(from prevArea: CGRect, to newArea: CGRect) {
    }
    
    func findBoardObject(at point: CGPoint) -> (any BoardObject)? {
//        for gameObject in gameObjects.set {
//            if let gameObject = gameObject.base as? (any BoardObject), gameObject.contains(point: point) {
//                return gameObject
//            }
//        }
        return nil
    }
}
