//
//  BoardObjectSet.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

struct BoardObjectSet {
    var blocks: Set<Block>
    var characters: Set<Character>
    var collectables: Set<Collectable>
    var enemies: Set<Enemy>
    var powerups: Set<Powerup>
    var allObjects: [any BoardObject] {
        Array(blocks) + Array(collectables) + Array(enemies) + Array(powerups)
    }

    init(blocks: Set<Block> = Set(),
         characters: Set<Character> = Set(),
         collectables: Set<Collectable> = Set(),
         enemies: Set<Enemy> = Set(),
         powerups: Set<Powerup> = Set()) {
        self.blocks = blocks
        self.characters = characters
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
        if let character = boardObject as? Character {
            characters.insert(character)
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
        if let character = boardObject as? Character {
            characters.remove(character)
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
        if let block = blocks.first(where: { $0.contains(point: point) }) {
            return block
        }
        if let character = characters.first(where: { $0.contains(point: point) }) {
            return character
        }
        if let collectable = collectables.first(where: { $0.contains(point: point) }) {
            return collectable
        }
        if let enemy = enemies.first(where: { $0.contains(point: point) }) {
            return enemy
        }
        if let powerup = powerups.first(where: { $0.contains(point: point) }) {
            return powerup
        }
        return nil
    }

    func nearestNonOverlappingPosition(for object: BoardObject) -> CGPoint {
        if allObjects.contains(where: { $0 !== object && $0.isOverlapping(with: object) }) {
            // If there's an overlap, calculate the nearest non-overlapping position
            var minDistance = CGFloat.greatestFiniteMagnitude
            var nearestPosition = object.position

            for existingObject in allObjects where existingObject !== object {
                let dx = existingObject.position.x - object.position.x
                let dy = existingObject.position.y - object.position.y
                let distance = sqrt(dx * dx + dy * dy)

                if distance < minDistance {
                    minDistance = distance
                    let overlapDistance = (object.width + existingObject.width) / 2
                    let ratio = overlapDistance / distance
                    let newX = object.position.x + dx * ratio
                    let newY = object.position.y + dy * ratio
                    nearestPosition = CGPoint(x: newX, y: newY)
                }
            }

            return nearestPosition
        } else {
            // If no overlap, return the object's current position
            return object.position
        }
    }

    mutating func removeAll() {
        blocks.removeAll()
        characters.removeAll()
        collectables.removeAll()
        enemies.removeAll()
        powerups.removeAll()
    }
}
