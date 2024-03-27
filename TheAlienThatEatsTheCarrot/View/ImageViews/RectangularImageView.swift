//
//  RectangularImageView.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 25/3/24.
//

import Foundation
import UIKit

class RectangularImageView: Hashable {

    let objectType: ObjectType
    var center: CGPoint
    var width: CGFloat
    var height: CGFloat
    var imageView: UIImageView!

    init(objectType: ObjectType, center: CGPoint, width: CGFloat, height: CGFloat) {
        self.objectType = objectType
        self.center = center
        self.width = width
        self.height = height
        setUpImageView()
    }

    func setUpImageView() {
        // Create UIImageView with the image
        self.imageView = UIImageView(image: #imageLiteral(resourceName: getImageName()))
        imageView.contentMode = .scaleAspectFill

        // Calculate the origin of the frame based on the center point and dimensions
        let originX = center.x - width / 2
        let originY = center.y - height / 2

        // Set the frame of the UIImageView
        imageView.frame = CGRect(x: originX, y: originY, width: width, height: height)
    }

    func resizeImage(scaleFactor: CGFloat) {
        width *= scaleFactor
        height *= scaleFactor
        let originX = center.x - width / 2
        let originY = center.y - height / 2
        imageView.frame = CGRect(x: originX, y: originY, width: width, height: height)
        imageView.contentMode = .scaleAspectFill
    }

    func getImageName() -> String {
        objectType.assetName ?? "land-top"
    }

    static func == (lhs: RectangularImageView, rhs: RectangularImageView) -> Bool {
        lhs.objectType == rhs.objectType &&
               lhs.center == rhs.center &&
               lhs.width == rhs.width &&
               lhs.height == rhs.height
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(objectType)
        hasher.combine(center)
        hasher.combine(width)
        hasher.combine(height)
    }

}
