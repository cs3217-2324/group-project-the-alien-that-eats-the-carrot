//
//  EventManager.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Justin Cheah Yun Fei on 27/3/24.
//

import Foundation

class EventManager {
    static let shared = EventManager()

    func postEvent<T: Event>(_ event: T) {
        NotificationCenter.default.post(name: T.name, object: event)
    }

    func subscribe<T: Event>(to eventType: T.Type, using block: @escaping (T) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: T.name, object: nil, queue: nil) { notification in
            if let event = notification.object as? T {
                block(event)
            }
        }
    }

    func unsubscribe(from observer: NSObjectProtocol) {
        NotificationCenter.default.removeObserver(observer)
    }
}
