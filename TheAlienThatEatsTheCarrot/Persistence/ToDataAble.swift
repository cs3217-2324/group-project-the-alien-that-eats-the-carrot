//
//  ToDataAble.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData

protocol ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject
}
