//
//  Direction.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 15/3/24.
//

import Foundation

struct Direction: Equatable {
    var radians: Double {
        didSet {
            radians = radians.truncatingRemainder(dividingBy: 2 * .pi)
        }
    }
    var degrees: Double {
        get { radians * 180 / .pi }
        set { radians = newValue * .pi / 180 }
    }

    init(radians: Double) {
        self.radians = radians.truncatingRemainder(dividingBy: 2 * .pi)
    }

    init(degrees: Double) {
        self.init(radians: degrees * .pi / 180)
    }

    static let up = Direction(radians: .pi * 1.5)
    static let down = Direction(radians: .pi / 2)
    static let left = Direction(radians: 0)
    static let right = Direction(radians: .pi)
}
