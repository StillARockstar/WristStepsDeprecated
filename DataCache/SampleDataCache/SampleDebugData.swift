//
//  SampleDebugData.swift
//  DataCache
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class SampleDebugData: DebugData {
    var lastBackgroundRefresh: Date? {
        get { return Date() }
        set { }
    }
    var lastDataRefresh: Date? {
        get { return Date() }
        set { }
    }
    var lastComlicationTrigger: Date? {
        get { return Date() }
        set { }
    }
    var lastComplicationRefresh: Date? {
        get { return Date() }
        set { }
    }
    var dataUpdateResult: StepCountUpdateResult? {
        get { return .none }
        set { }
    }
    var scheduleRefreshError: String? {
        get { return nil }
        set { }
    }
    var pedometerGetStepCountError: String? {
        get { return nil }
        set { }
    }
}
