//
//  DataCache.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 25.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

fileprivate enum DataCacheEntryKey: String {
    case stepCount = "keyStepCount"
}

let DataCacheValueUpdatedNotificationName = Notification.Name(rawValue: "DataCacheValueUpdatedNotification")

class DataCache {
    static var shared: DataCache = {
        return DataCache()
    }()

    private init() { }

    var stepCount: Int {
        get {
            return read(key: .stepCount) as? Int ?? 0
        }
        set {
            write(value: newValue, key: .stepCount)
            NotificationCenter.default.post(name: DataCacheValueUpdatedNotificationName, object: nil)
        }
    }
}

private extension DataCache {
    func write(value: Any?, key: DataCacheEntryKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func read(key: DataCacheEntryKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
}
