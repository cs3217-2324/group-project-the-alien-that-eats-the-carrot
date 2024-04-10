//
//  HasCoolDown.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 10/4/24.
//

import Foundation

protocol HasCoolDown {
    var coolDownDuration: CGFloat { get set }
    var isCoolingDown: Bool { get set }
}
