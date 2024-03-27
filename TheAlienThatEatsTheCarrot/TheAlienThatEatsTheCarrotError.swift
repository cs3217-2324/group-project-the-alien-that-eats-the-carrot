//
//  TheAlienThatEatsTheCarrotError.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

enum TheAlienThatEatsTheCarrotError: Error {
    case invalidObjectTypeDataError(typeName: String?)
    case invalidPersistenceDataError
    case duplicateLevelNameError(levelName: String)

    var errorMessage: String? {
        switch self {
        case .invalidObjectTypeDataError(let typeName):
            return "'\(String(describing: typeName))' is an invalid block type"
        case .invalidPersistenceDataError:
            return "Persistence data is invalid"
        case .duplicateLevelNameError(let levelName):
            return "'\(levelName)' is a duplicate name. This is not allowed"
        }
    }
}
