import Foundation

// Define Codable structures for JSON encoding and decoding
struct JSONLevel: Codable {
    var name: String
    var area: [CGFloat]
    var boardObjects: JSONBoardObjectSet
    var bestScore: Int
    var bestTime: Int
    var bestCarrot: Int
}

struct JSONBoardObjectSet: Codable {
    var blocks: [JSONBlock]
    var characters: [JSONCharacter]
    var collectables: [JSONCollectable]
    var enemies: [JSONEnemy]
    var powerups: [JSONPowerup]
}

struct JSONBlock: Codable {
    var position: [CGFloat]
    var blockType: String
    var containedPowerupType: String?
}

struct JSONCharacter: Codable {
    var position: [CGFloat]
    var characterType: String
}

struct JSONCollectable: Codable {
    var position: [CGFloat]
    var collectableType: String
}

struct JSONEnemy: Codable {
    var position: [CGFloat]
    var enemyType: String
}

struct JSONPowerup: Codable {
    var position: [CGFloat]
    var powerupType: String
}

// Extension to convert a Level instance to JSON string
extension Level {
    func toJSONString() -> String? {
        let jsonLevel = JSONLevel(name: name,
                                  area: [area.origin.x, area.origin.y, area.size.width, area.size.height],
                                  boardObjects: boardObjects.toJSONBoardObjectSet(),
                                  bestScore: bestScore,
                                  bestTime: bestTime,
                                  bestCarrot: bestCarrot)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(jsonLevel)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

// Extension to convert a BoardObjectSet instance to JSONBoardObjectSet
extension BoardObjectSet {
    func toJSONBoardObjectSet() -> JSONBoardObjectSet {
        let jsonBlocks = blocks.map { block in
            JSONBlock(position: [block.position.x, block.position.y],
                      blockType: block.blockType.rawValue,
                      containedPowerupType: block.containedPowerupType?.rawValue)
        }
        let jsonCharacters = characters.map { character in
            JSONCharacter(position: [character.position.x, character.position.y],
                          characterType: character.characterType.rawValue)
        }
        let jsonCollectables = collectables.map { collectable in
            JSONCollectable(position: [collectable.position.x, collectable.position.y],
                            collectableType: collectable.collectableType.rawValue)
        }
        let jsonEnemies = enemies.map { enemy in
            JSONEnemy(position: [enemy.position.x, enemy.position.y],
                      enemyType: enemy.enemyType.rawValue)
        }
        let jsonPowerups = powerups.map { powerup in
            JSONPowerup(position: [powerup.position.x, powerup.position.y],
                        powerupType: powerup.powerupType.rawValue)
        }

        return JSONBoardObjectSet(blocks: jsonBlocks,
                                  characters: jsonCharacters,
                                  collectables: jsonCollectables,
                                  enemies: jsonEnemies,
                                  powerups: jsonPowerups)
    }
}

// Extension to convert JSON string to Level instance
extension Level {
    static func fromJSONString(jsonString: String) -> Level? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed to convert JSON string to data")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let jsonLevel = try decoder.decode(JSONLevel.self, from: jsonData)

            // Convert area from array to CGRect
            let area = CGRect(x: jsonLevel.area[0], y: jsonLevel.area[1], width: jsonLevel.area[2], height: jsonLevel.area[3])

            // Convert JSONBoardObjectSet to BoardObjectSet
            let boardObjects = jsonLevel.boardObjects.toBoardObjectSet()

            return Level(area: area, name: jsonLevel.name,
                         boardObjects: boardObjects,
                         bestScore: jsonLevel.bestScore,
                         bestTime: jsonLevel.bestTime,
                         bestCarrot: jsonLevel.bestCarrot)
        } catch {
            return nil
        }
    }
}

extension JSONLevel {
    func toLevel() -> Level? {
        // Convert area from array to CGRect
        let area = CGRect(x: self.area[0], y: self.area[1], width: self.area[2], height: self.area[3])

        // Convert JSONBoardObjectSet to BoardObjectSet
        let boardObjects = self.boardObjects.toBoardObjectSet()

        return Level(area: area, name: self.name,
                     boardObjects: boardObjects,
                     bestScore: self.bestScore,
                     bestTime: self.bestTime,
                     bestCarrot: self.bestCarrot)
    }
}

// Extension to convert JSONBoardObjectSet to BoardObjectSet
extension JSONBoardObjectSet {
    func toBoardObjectSet() -> BoardObjectSet {
        let blocks = Set(self.blocks.map { block in
            Block(blockType: BlockType(rawValue: block.blockType)!,
                         containedPowerupType: block.containedPowerupType != nil ? PowerupType(rawValue: block.containedPowerupType!) : nil,
                         position: CGPoint(x: block.position[0], y: block.position[1]))
        })
        let characters = Set(self.characters.map { character in
            Character(characterType: CharacterType(rawValue: character.characterType)!, position: CGPoint(x: character.position[0], y: character.position[1]))
        })
        let collectables = Set(self.collectables.map { collectable in
            Collectable(collectableType: CollectableType(rawValue: collectable.collectableType)!,
                               position: CGPoint(x: collectable.position[0], y: collectable.position[1]))
        })
        let enemies = Set(self.enemies.map { enemy in
            Enemy(enemyType: EnemyType(rawValue: enemy.enemyType)!,
                         position: CGPoint(x: enemy.position[0], y: enemy.position[1]))
        })
        let powerups = Set(self.powerups.map { powerup in
            Powerup(powerupType: PowerupType(rawValue: powerup.powerupType)!,
                           position: CGPoint(x: powerup.position[0], y: powerup.position[1]))
        })

        return BoardObjectSet(blocks: blocks,
                              characters: characters,
                              collectables: collectables,
                              enemies: enemies,
                              powerups: powerups)
    }
}

func main() {
    // Example usage
    let level = Level(area: CGRect(x: 0, y: 0, width: 100, height: 100), name: "Test Level",
                      boardObjects: BoardObjectSet(blocks: [], characters: [], collectables: [], enemies: [], powerups: []),
                      bestScore: 0,
                      bestTime: 0,
                      bestCarrot: 0)
}
