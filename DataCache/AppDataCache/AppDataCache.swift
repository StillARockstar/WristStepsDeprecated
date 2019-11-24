//
//  DataCache.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public class AppDataCache: DataCache {
    public var healthData: HealthData!
    public var userData: UserData!
    public var debugData: DebugData!

    private var healthDataListeners = [DataCacheListener]()
    private var userDataListeners = [DataCacheListener]()
    private var debugDataListeners = [DataCacheListener]()

    required public init() { }

    public func prepare() {
        let dataStore = DataStore()
        healthData = AppHealthData(dataStore: dataStore)
        (healthData as? DataEntity)?.onDataChanged = onHealthDataChanged

        userData = AppUserData(dataStore: dataStore)
        (userData as? DataEntity)?.onDataChanged = onUserDataChanged

        debugData = AppDebugData(dataStore: dataStore)
        (debugData as? DataEntity)?.onDataChanged = onDebugDataChanged
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
