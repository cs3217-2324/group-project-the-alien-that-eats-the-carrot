//
//  BlockType+extension.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

extension BlockType: FromDataAble {
    init(data: BlockTypeData) throws {
        guard let name = data.typeName, let type = BlockType(rawValue: name) else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: data.typeName)
        }
        self = type
    }
}

extension BlockType: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let blockTypeData = BlockTypeData(context: context)
        blockTypeData.typeName = self.rawValue
        return blockTypeData as NSManagedObject
    }
}
