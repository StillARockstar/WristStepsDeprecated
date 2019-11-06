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
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func read(key: DataCacheEntryKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
}
