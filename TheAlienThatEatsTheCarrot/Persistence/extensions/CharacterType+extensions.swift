//
//  CharacterType+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 15/4/24.
//

import CoreData

extension CharacterType: FromDataAble {
    init(data: CharacterTypeData) throws {
        guard let name = data.typeName, let type = CharacterType(rawValue: name) else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: data.typeName)
        }
        self = type
    }
}

extension CharacterType: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let characterTypeData = CharacterTypeData(context: context)
        characterTypeData.typeName = self.rawValue
        return characterTypeData as NSManagedObject
    }
}
