//
//  KeyValueStore.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 22.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

enum KeyValueKey: String {
    case stepCount = "keyStepCount"
}

class KeyValueStore {
    static var shared: KeyValueStore = {
        return KeyValueStore()
    }()

    private init() { }

    func store(value: Any, key: KeyValueKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func read(key: KeyValueKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }

    func remove(key: KeyValueKey) {
        UserDefaults.standard.set(nil, forKey: key.rawValue)
    }
}
