//
//  Component.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 11/3/24.
//

import Foundation

/// All components should conform to this
protocol Component {
    static var typeId: ComponentIdentifier { get }
    var entity: Entity { get }
}

extension Component {
    static var typeId: ComponentIdentifier { ComponentIdentifier(Self.self) }
}
