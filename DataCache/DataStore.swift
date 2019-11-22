//
//  DataStore.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class DataStore {
    func write(value: Any?, key: DataCacheEntryKey) {
        write(value: value, key: key.rawValue)
    }

    func read(key: DataCacheEntryKey) -> Any? {
        return read(key: key.rawValue)
    }

    func write(value: Any?, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func read(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
