//
//  CGPoint+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData
import CoreGraphics

extension CGPoint: FromDataAble {
    init(data: CGPointData) throws {
        self.init(x: data.x, y: data.y)
    }
}

extension CGPoint: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let pointData = CGPointData(context: context)
        pointData.x = x
        pointData.y = y
        return pointData as NSManagedObject
    }
}
