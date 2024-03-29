//
//  PowerupType+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension PowerupType: FromDataAble {
    init(data: PowerupTypeData) throws {
      guard let name = data.typeName,
                let type = PowerupType(rawValue: name) else {
              throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: data.typeName)
          }
          self = type
    }
}

extension PowerupType: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let powerupTypeData = PowerupTypeData(context: context)
        powerupTypeData.typeName = self.rawValue
        return powerupTypeData as NSManagedObject
    }
}
