//
//  GameObject.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 12/3/24.
//

import CoreGraphics

protocol BoardObject: AnyObject {
    var position: CGPoint { get set }
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var imageName: String? { get set }
    var type: ObjectType { get }

    func move(to newPosition: CGPoint)
    func isOverlapping(with boardObject: BoardObject) -> Bool
    func contains(point: CGPoint) -> Bool
}
