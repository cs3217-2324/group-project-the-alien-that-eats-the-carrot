//
//  Collectable+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension Collectable: FromDataAble {
    convenience init(data: CollectableData) throws {
        guard let positionData = data.position, let typeData = data.type else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "collectable")
        }
        let position = try CGPoint(data: positionData)
        let type = try CollectableType(data: typeData)
        self.init(collectableType: type, position: position)
    }
}

extension Collectable: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let collectableData = CollectableData(context: context)
        collectableData.position = self.position.toData(context: context) as? CGPointData
        collectableData.type = self.collectableType.toData(context: context) as? CollectableTypeData
        return collectableData as NSManagedObject
    }
}
