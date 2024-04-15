//
//  Achievement.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 11/4/24.
//

protocol Achievement: AnyObject {
    var name: String { get }
    var isCompleted: Bool { get set }
    var isRepeatable: Bool { get }

    func checkIfCompleted(gameStats: GameStats?) -> Bool
}
