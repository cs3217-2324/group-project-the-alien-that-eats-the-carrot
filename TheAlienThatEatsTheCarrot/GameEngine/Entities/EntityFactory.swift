//
//  EntityFactory.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 22/3/24.
//

import Foundation

protocol EntityFactory {
    func createComponents() -> [Component]
}
