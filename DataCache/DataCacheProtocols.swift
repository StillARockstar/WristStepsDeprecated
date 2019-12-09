//
//  DataCacheProtocols.swift
//  DataCache
//
//  Created by Michael Schoder on 09.12.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public enum DataCacheEntryKey: String {
    case stepCount = "keyStepCount"
    case stepGoal = "keyStepGoal"
    case backgroundRefresh = "keyBackgroundRefresh"
    case dataRefresh = "keyDataRefresh"
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

protocol DataEntity: class {
    var onDataChanged: (() -> Void)? { get set }
    init(dataStore: DataStore)
}

public protocol DataCache: class {
    var healthData: HealthData! { get }
    var userData: UserData! { get }
    var debugData: DebugData! { get }

    init()
    func prepare()

    func addListener(_ listener: DataCacheListener, for dataSetTypes: [DataSetType])
    func removeListener(_ listener: DataCacheListener)
}

public protocol HealthData: class {
    var stepCount: Int { get set }
}

public protocol UserData: class {
    var stepGoal: Int { get set }
}

public protocol DebugData: class {
    var lastBackgroundRefresh: Date? { get set }
    var lastDataRefresh: Date? { get set }
    var lastComlicationTrigger: Date? { get set }
    var lastComplicationRefresh: Date? { get set }
    var dataUpdateResult: StepCountUpdateResult? { get set }
    var scheduleRefreshError: String? { get set }
    var pedometerGetStepCountError: String? { get set }
}
