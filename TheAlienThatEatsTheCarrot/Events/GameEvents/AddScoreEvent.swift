//
//  AddScoreEvent.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 31/3/24.
//

import Foundation

struct AddScoreEvent: Event {
    static var name: Notification.Name = .addScore
    let score: Int
}

extension Notification.Name {
    static let addScore = Notification.Name("addScore")
}
