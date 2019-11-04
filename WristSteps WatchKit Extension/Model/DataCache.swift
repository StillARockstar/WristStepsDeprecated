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
    case stepGoal = "keyStepGoal"
    case backgroundRefresh = "keyBackgroundRefresh"
    case complicationTrigger = "keyComplicationTrigger"
    case complicationRefresh = "keyComplicationRefresh"
    case stepCountUpdateResult = "keyStepCountUpdateResult"
    case scheduleRefreshError = "keyScheduleRefreshError"
    case pedometerStepCountError = "keyPedometerStepCountError"
}

enum StepCountUpdateResult: String {
    case pedometer = "Pedometer"
    case noUpdate = "No Update"
    case forcedZero = "Forced Zero"
}

let DataCacheValueUpdatedNotificationName = Notification.Name(rawValue: "DataCacheValueUpdatedNotification")

class DataCache {
    static var shared: DataCache = {
        return DataCache()
    }()

    private let defaultStepCount = 0
    private let defaultStepGoal = 10000

    private init() { }

    var stepCount: Int {
        get {
            return read(key: .stepCount) as? Int ?? defaultStepCount
        }
        set {
            write(value: newValue, key: .stepCount)
            NotificationCenter.default.post(name: DataCacheValueUpdatedNotificationName, object: nil)
        }
    }

    var stepGoal: Int {
        get {
            return read(key: .stepGoal) as? Int ?? defaultStepGoal
        }
        set {
            write(value: newValue, key: .stepGoal)
            NotificationCenter.default.post(name: DataCacheValueUpdatedNotificationName, object: nil)
        }
    }

    var lastBackgroundRefresh: Date? {
        get {
            return read(key: .backgroundRefresh) as? Date
        }
        set {
            write(value: newValue, key: .backgroundRefresh)
        }
    }

    var lastComlicationTrigger: Date? {
        get {
            return read(key: .complicationTrigger) as? Date
        }
        set {
            write(value: newValue, key: .complicationTrigger)
        }
    }

    var lastComplicationRefresh: Date? {
        get {
            return read(key: .complicationRefresh) as? Date
        }
        set {
            write(value: newValue, key: .complicationRefresh)
        }
    }

    var dataUpdateResult: StepCountUpdateResult? {
        get {
            return StepCountUpdateResult(rawValue: read(key: .stepCountUpdateResult) as? String ?? "")
        }
        set {
            write(value: newValue?.rawValue, key: .stepCountUpdateResult)
        }
    }

    var scheduleRefreshError: String? {
        get {
            return read(key: .scheduleRefreshError) as? String
        }
        set {
            write(value: newValue, key: .scheduleRefreshError)
        }
    }

    var pedometerGetStepCountError: String? {
        get {
            return read(key: .pedometerStepCountError) as? String
        }
        set {
            write(value: newValue, key: .pedometerStepCountError)
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
