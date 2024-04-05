//
//  CGFloat+extensions.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

extension CGFloat {
    func square() -> CGFloat {
        self * self
    }

    func clamped(_ vec1: CGFloat, _ vec2: CGFloat) -> CGFloat {
        let min = vec1 < vec2 ? vec1 : vec2
        let max = vec1 > vec2 ? vec1 : vec2
        return self < min ? min : (self > max ? max : self)
    }
    
    var sign: CGFloat {
        if self > 0 {
            return 1.0
        } else if self < 0 {
            return -1.0
        } else {
            return 0.0
        }
    }
}
