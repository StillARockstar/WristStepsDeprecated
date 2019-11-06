//
//  DataCache.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public enum DataCacheEntryKey: String {
    case stepCount = "keyStepCount"
    case stepGoal = "keyStepGoal"
    case backgroundRefresh = "keyBackgroundRefresh"
    case complicationTrigger = "keyComplicationTrigger"
    case complicationRefresh = "keyComplicationRefresh"
    case stepCountUpdateResult = "keyStepCountUpdateResult"
    case scheduleRefreshError = "keyScheduleRefreshError"
    case pedometerStepCountError = "keyPedometerStepCountError"
}

public enum StepCountUpdateResult: String {
    case pedometer = "Pedometer"
    case noUpdate = "No Update"
}

public enum DataSetType {
    case healthData
    case userData
    case debugData
}

public protocol DataCacheListener: class {
    func healthDataChanged(_ dataCache: DataCache)
    func userDataChanged(_ dataCache: DataCache)
    func debugDataChanged(_ dataCache: DataCache)
}

public class DataCache {
    public var healthData: HealthData!
    public var userData: UserData!
    public var debugData: DebugData!

    private var healthDataListeners = [DataCacheListener]()
    private var userDataListeners = [DataCacheListener]()
    private var debugDataListeners = [DataCacheListener]()

    public init() { }

    public func prepare() {
        let dataStore = DataStore()
        healthData = HealthData(dataStore: dataStore)
        healthData.onDataChanged = onHealthDataChanged

        userData = UserData(dataStore: dataStore)
        userData.onDataChanged = onUserDataChanged

        debugData = DebugData(dataStore: dataStore)
        debugData.onDataChanged = onDebugDataChanged
    }

    private func onHealthDataChanged() {
        for listener in healthDataListeners {
            listener.healthDataChanged(self)
        }
    }

    private func onUserDataChanged() {
        for listener in userDataListeners {
            listener.userDataChanged(self)
        }
    }

    private func onDebugDataChanged() {
        for listener in debugDataListeners {
            listener.debugDataChanged(self)
        }
    }

    public func addListener(_ listener: DataCacheListener, for dataSetTypes: [DataSetType]) {
        for dataSetType in dataSetTypes {
            if dataSetType == .healthData {
                healthDataListeners.append(listener)
            }
            if dataSetType == .userData {
                userDataListeners.append(listener)
            }
            if dataSetType == .debugData {
                debugDataListeners.append(listener)
            }
        }
    }

    public func removeListener(_ listener: DataCacheListener) {
        healthDataListeners.removeAll { ObjectIdentifier($0) == ObjectIdentifier(listener) }
        userDataListeners.removeAll { ObjectIdentifier($0) == ObjectIdentifier(listener) }
        debugDataListeners.removeAll { ObjectIdentifier($0) == ObjectIdentifier(listener) }
    }
}
