//
//  FromDataAble.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

protocol FromDataAble {
    associatedtype PeggleDataType: NSManagedObject

    init(data: PeggleDataType) throws
}
