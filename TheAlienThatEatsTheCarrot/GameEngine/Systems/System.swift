//
//  System.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Jair Goh on 11/3/24.
//

import CoreGraphics

protocol System {
    var nexus: Nexus { get }

    func update(deltaTime: CGFloat)
}
