//
//  SampleDataCache.swift
//  DataCache
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public class SampleDataCache: DataCache {
    public var healthData: HealthData!
    public var userData: UserData!
    public var debugData: DebugData!

    required public init() { }

    public func prepare() {
        healthData = SampleHealthData()
        userData = SampleUserData()
        debugData = SampleDebugData()
    }

    public func addListener(_ listener: DataCacheListener, for dataSetTypes: [DataSetType]) { }
    public func removeListener(_ listener: DataCacheListener) { }
}
