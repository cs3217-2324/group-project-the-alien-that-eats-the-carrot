//
//  Level+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreGraphics
import CoreData

extension Level: FromDataAble {
    init(data: LevelData) throws {
        guard let levelName = data.name else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: data.name)
        }
        guard let areaData = data.areaData else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "area datas")
        }
        guard let blockDatas = data.blockDatas else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "block datas")
        }
        guard let characterDatas = data.characterDatas else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "character datas")
        }
        guard let collectableDatas = data.collectableDatas else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "collectable datas")
        }
        guard let enemyDatas = data.enemyDatas else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "enemy datas")
        }
        guard let powerupDatas = data.powerupDatas else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "powerup datas")
        }

        self.name = levelName
        self.bestScore = Int(data.bestScore)
        self.bestTime = Int(data.bestTime)
        self.bestCarrot = Int(data.bestCarrot)
        self.area = try CGRect(data: areaData)
        self.boardObjects = BoardObjectSet()
        try self.boardObjects.loadBlocks(nsSet: blockDatas)
        try self.boardObjects.loadCharacters(nsSet: characterDatas)
        try self.boardObjects.loadCollectables(nsSet: collectableDatas)
        try self.boardObjects.loadEnemies(nsSet: enemyDatas)
        try self.boardObjects.loadPowerups(nsSet: powerupDatas)
    }
}

extension BoardObjectSet {
    mutating func loadBlocks(nsSet: NSSet) throws {
        let blockDatas = nsSet.compactMap({ $0 as? BlockData })
        guard blockDatas.count == nsSet.count else {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        }
        for blockData in blockDatas {
            let block = try Block(data: blockData)
            add(boardObject: block)
        }
    }

    mutating func loadCharacters(nsSet: NSSet) throws {
        let characterDatas = nsSet.compactMap({ $0 as? CharacterData })
        guard characterDatas.count == nsSet.count else {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        }
        for characterData in characterDatas {
            let character = try Character(data: characterData)
            add(boardObject: character)
        }
    }

    mutating func loadCollectables(nsSet: NSSet) throws {
        let collectableDatas = nsSet.compactMap({ $0 as? CollectableData })
        guard collectableDatas.count == nsSet.count else {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        }
        for collectableData in collectableDatas {
            let collectable = try Collectable(data: collectableData)
            add(boardObject: collectable)
        }
    }

    mutating func loadEnemies(nsSet: NSSet) throws {
        let enemyDatas = nsSet.compactMap({ $0 as? EnemyData })
        guard enemyDatas.count == nsSet.count else {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        }
        for enemyData in enemyDatas {
            let enemy = try Enemy(data: enemyData)
            add(boardObject: enemy)
        }
    }

    mutating func loadPowerups(nsSet: NSSet) throws {
        let powerupDatas = nsSet.compactMap({ $0 as? PowerupData })
        guard powerupDatas.count == nsSet.count else {
            throw TheAlienThatEatsTheCarrotError.invalidPersistenceDataError
        }
        for powerupData in powerupDatas {
            let powerup = try Powerup(data: powerupData)
            add(boardObject: powerup)
        }
    }
}

extension Level: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let levelData = LevelData(context: context)
        levelData.name = name
        levelData.bestTime = Int64(bestTime)
        levelData.bestScore = Int64(bestScore)
        levelData.bestCarrot = Int16(bestCarrot)
        levelData.areaData = area.toData(context: context) as? CGRectData

        var blockDatas = Set<BlockData>()
        var characterDatas = Set<CharacterData>()
        var collectableDatas = Set<CollectableData>()
        var enemyDatas = Set<EnemyData>()
        var powerupDatas = Set<PowerupData>()

        for block in self.boardObjects.blocks {
            if let blockData = block.toData(context: context) as? BlockData {
                blockDatas.insert(blockData)
            }
        }
        for character in self.boardObjects.characters {
            if let characterData = character.toData(context: context) as? CharacterData {
                characterDatas.insert(characterData)
            }
        }
        for collectable in self.boardObjects.collectables {
            if let collectableData = collectable.toData(context: context) as? CollectableData {
                collectableDatas.insert(collectableData)
            }
        }
        for enemy in self.boardObjects.enemies {
            if let enemyData = enemy.toData(context: context) as? EnemyData {
                enemyDatas.insert(enemyData)
            }
        }
        for powerup in self.boardObjects.powerups {
            if let powerupData = powerup.toData(context: context) as? PowerupData {
                powerupDatas.insert(powerupData)
            }
        }

        levelData.addToBlockDatas(NSSet(set: blockDatas))
        levelData.addToCollectableDatas(NSSet(set: collectableDatas))
        levelData.addToEnemyDatas(NSSet(set: enemyDatas))
        levelData.addToPowerupDatas(NSSet(set: powerupDatas))

        return levelData as NSManagedObject
    }
}
