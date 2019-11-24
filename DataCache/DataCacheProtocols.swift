//
//  DataCacheProtocols.swift
//  DataCache
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

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

    func setSelectedTemplateStyleId(for family: CLKComplicationFamily, templateStyleId: String)
    func getSelectedTemplateStyleId(for family: CLKComplicationFamily) -> String?
    func setSelectedColorStyleId(for family: CLKComplicationFamily, colorStyleId: String)
    func getSelectedColorStyleId(for family: CLKComplicationFamily) -> String?
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

extension CLKComplicationFamily {
    var dataCacheId: String? {
        switch self {
        case .modularSmall:
            return "sm"
        case .modularLarge:
            return "ml"
        case .utilitarianSmall:
            return "us"
        case .utilitarianSmallFlat:
            return "usf"
        case .utilitarianLarge:
            return "ul"
        case .circularSmall:
            return "cs"
        case .extraLarge:
            return "el"
        case .graphicCorner:
            return "gc"
        case .graphicBezel:
            return "gb"
        case .graphicCircular:
            return "gci"
        case .graphicRectangular:
            return "gr"
        @unknown default:
            return nil
        }
    }
}
