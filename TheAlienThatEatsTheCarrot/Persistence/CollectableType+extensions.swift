//
//  CollectableType+extension.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension CollectableType: FromDataAble {
  init(data: CollectableTypeData) throws {
    guard let name = data.typeName,
              let type = CollectableType.typeNameToTypeMap[name] else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: data.typeName)
        }
        self = type
  }
}

extension CollectableType: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let collectableTypeData = BlockTypeData(context: context)
        collectableTypeData.typeName = CollectableType.typeToTypeNameMap[self]
        return collectableTypeData as NSManagedObject
    }
}
