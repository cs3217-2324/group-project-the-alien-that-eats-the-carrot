//
//  TheAlienThatEatsTheCarrotError.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

enum TheAlienThatEatsTheCarrotError: Error {
    case invalidObjectTypeDataError(typeName: String?)
    case invalidNSSetDataError

    var errorMessage: String? {
        switch self {
        case .invalidObjectTypeDataError(let typeName):
            return "'\(String(describing: typeName))' is an invalid block type"
        case .invalidNSSetDataError:
            return "Persistence data is invalid"
        }
    }
}
