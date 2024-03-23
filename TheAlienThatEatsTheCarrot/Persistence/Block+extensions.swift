//
//  Block+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension Block: FromDataAble {
    convenience init(data: BlockData) throws {
        guard let positionData = data.position, let blockTypeData = data.type, let containedPowerupData = data.contains else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "block")
        }
        let position = try CGPoint(data: positionData)
        let blockType = try BlockType(data: blockTypeData)
        let containedPowerupType = try PowerupType(data: containedPowerupData)
        self.init(blockType: blockType, containedPowerupType: containedPowerupType, position: position)
    }
}

extension Block: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let blockData = BlockData(context: context)
        blockData.position = self.position.toData(context: context) as? CGPointData
        blockData.type = self.blockType.toData(context: context) as? BlockTypeData
        blockData.contains = self.containedPowerupType?.toData(context: context) as? PowerupTypeData
        return blockData as NSManagedObject
    }
}
