//
//  AttackStyle.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 30/3/24.
//

import Foundation

protocol AttackStyle {
    func attack(attacker: Entity, attackee: Entity, delegate: AttackableDelegate)
}
