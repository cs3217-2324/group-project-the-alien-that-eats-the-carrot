//
//  CGRect+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import CoreData
import CoreGraphics

extension CGRect: FromDataAble {
    init(data: CGRectData) throws {
        guard let positionData = data.position else {
            throw TheAlienThatEatsTheCarrotError.invalidObjectTypeDataError(typeName: "CGRect")
        }
        let height = data.height
        let width = data.width
        let position = try CGPoint(data: positionData)
        self.init(x: position.x, y: position.y, width: width, height: height)
    }
}

extension CGRect: ToDataAble {
    func toData(context: NSManagedObjectContext) -> NSManagedObject {
        let rectData = CGRectData(context: context)
        rectData.position = self.origin.toData(context: context) as? CGPointData
        rectData.height = self.height
        rectData.width = self.width
        return rectData as NSManagedObject
    }
}

extension CGRect {
    func extendOnXAxis(by distance: CGFloat) -> CGRect {
        CGRect(x: self.minX, y: self.minY, width: self.width + distance, height: self.height)
    }
}
