//
//  Character+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 15/4/24.
//

import CoreData

extension Character: FromDataAble {
    convenience init(data: CharacterData) throws {
        guard let positionData = data.position, let characterTypeData = data.type else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "character")
        }
        let position = try CGPoint(data: positionData)
        let characterType = try CharacterType(data: characterTypeData)
        self.init(characterType: characterType, position: position)
    }
}

extension Character: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let characterData = CharacterData(context: context)
        characterData.position = self.position.toData(context: context) as? CGPointData
        characterData.type = self.characterType.toData(context: context) as? CharacterTypeData
        return characterData as NSManagedObject
    }
}
