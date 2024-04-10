//
//  RenderableComponent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

class RenderableComponent: Component {
    var entity: Entity
    var position: CGPoint
    var size: CGSize
    var objectType: ObjectType

    init(entity: Entity, position: CGPoint, objectType: ObjectType,
         size: CGSize = GameConstants.DEFAULT_ASSET_SIZE) {
        self.entity = entity
        self.position = position
        self.objectType = objectType
        self.size = size
    }
}

extension RenderableComponent {
    func overlapsWith(_ other: RenderableComponent) -> Bool {
        let myRect = getRect(position: position, size: size)
        let otherRect = getRect(position: other.position, size: other.size)

        return myRect.intersects(otherRect)
    }

    func getRect(position: CGPoint, size: CGSize) -> CGRect {
        let myOrigin = CGPoint(x: position.x - size.width / 2, y: position.y - size.height / 2)

        return CGRect(origin: myOrigin, size: size)
    }

    func getRect() -> CGRect {
        let myOrigin = CGPoint(x: position.x - size.width / 2, y: position.y - size.height / 2)

        return CGRect(origin: myOrigin, size: size)
    }
}
