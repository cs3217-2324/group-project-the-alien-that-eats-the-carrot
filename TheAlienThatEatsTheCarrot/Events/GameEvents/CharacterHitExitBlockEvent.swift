//
//  CharacterHitExitBlockEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 15/4/24.
//

import Foundation

class CharacterHitExitBlockEvent: Event {
    static var name: Notification.Name = .characterHitExitBlock
}

extension Notification.Name {
    static let characterHitExitBlock = Notification.Name("characterHitExitBlock")
}
