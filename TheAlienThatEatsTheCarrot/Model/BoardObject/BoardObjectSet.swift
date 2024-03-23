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
        // TODO: check overlap
        switch boardObject {
        case is Block:
            blocks.insert(boardObject as! Block)
        case is Collectable:
            collectables.insert(boardObject as! Collectable)
        case is Enemy:
            enemies.insert(boardObject as! Enemy)
        case is Powerup:
            powerups.insert(boardObject as! Powerup)
        default:
            return
        }
    }

    mutating func remove(boardObject: any BoardObject) {
        switch boardObject {
        case is Block:
            blocks.remove(boardObject as! Block)
        case is Collectable:
            collectables.remove(boardObject as! Collectable)
        case is Enemy:
            enemies.remove(boardObject as! Enemy)
        case is Powerup:
            powerups.remove(boardObject as! Powerup)
        default:
            return
        }
    }

    mutating func scale(from prevArea: CGRect, to newArea: CGRect) {
        
    }
}
