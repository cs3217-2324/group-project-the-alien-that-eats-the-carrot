//
//  Powerup+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension Powerup: FromDataAble {
    convenience init(data: PowerupData) throws {
        guard let positionData = data.position, let typeData = data.type else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "powerup")
        }
        let position = try CGPoint(data: positionData)
        let type = try PowerupType(data: typeData)
        self.init(powerupType: type, position: position)
    }
}

extension Powerup: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let powerupData = CollectableData(context: context)
        powerupData.position = self.position.toData(context: context) as? CGPointData
        powerupData.type = self.powerupType.toData(context: context) as? CollectableTypeData
        return powerupData as NSManagedObject
    }
}
