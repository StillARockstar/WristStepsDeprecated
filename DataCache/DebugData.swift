//
//  DebugData.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public class DebugData {
    private let dataStore: DataStore

    var onDataChanged: (() -> Void)?

    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    public var lastBackgroundRefresh: Date? {
        get {
            return dataStore.read(key: .backgroundRefresh) as? Date
        }
        set {
            dataStore.write(value: newValue, key: .backgroundRefresh)
            onDataChanged?()
        }
    }

    public var lastComlicationTrigger: Date? {
        get {
            return dataStore.read(key: .complicationTrigger) as? Date
        }
        set {
            dataStore.write(value: newValue, key: .complicationTrigger)
            onDataChanged?()
        }
    }

    public var lastComplicationRefresh: Date? {
        get {
            return dataStore.read(key: .complicationRefresh) as? Date
        }
        set {
            dataStore.write(value: newValue, key: .complicationRefresh)
            onDataChanged?()
        }
    }

    public var dataUpdateResult: StepCountUpdateResult? {
        get {
            return StepCountUpdateResult(rawValue: dataStore.read(key: .stepCountUpdateResult) as? String ?? "")
        }
        set {
            dataStore.write(value: newValue?.rawValue, key: .stepCountUpdateResult)
            onDataChanged?()
        }
    }

    public var scheduleRefreshError: String? {
        get {
            return dataStore.read(key: .scheduleRefreshError) as? String
        }
        set {
            dataStore.write(value: newValue, key: .scheduleRefreshError)
            onDataChanged?()
        }
    }

    public var pedometerGetStepCountError: String? {
        get {
            return dataStore.read(key: .pedometerStepCountError) as? String
        }
        set {
            dataStore.write(value: newValue, key: .pedometerStepCountError)
            onDataChanged?()
        }
    }
}
