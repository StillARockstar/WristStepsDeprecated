//
//  HealthData.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public class AppHealthData: DataEntity, HealthData {
    private let dataStore: DataStore
    private let defaultStepCount = 0

    var onDataChanged: (() -> Void)?

    required init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    public var stepCount: Int {
        get {
            return dataStore.read(key: .stepCount) as? Int ?? defaultStepCount
        }
        set {
            dataStore.write(value: newValue, key: .stepCount)
            onDataChanged?()
        }
    }
}
