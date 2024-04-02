//
//  Enemy+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension Enemy: FromDataAble {
    convenience init(data: EnemyData) throws {
        guard let positionData = data.position, let typeData = data.type else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "enemy")
        }
        let position = try CGPoint(data: positionData)
        let type = try EnemyType(data: typeData)
        self.init(enemyType: type, position: position)
    }
}

extension Enemy: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let enemyData = EnemyData(context: context)
        enemyData.position = self.position.toData(context: context) as? CGPointData
        enemyData.type = self.enemyType.toData(context: context) as? EnemyTypeData
        return enemyData as NSManagedObject
    }
}
