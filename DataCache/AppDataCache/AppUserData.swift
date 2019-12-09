//
//  UserData.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

public class AppUserData: DataEntity, UserData {
    private let dataStore: DataStore
    private let defaultStepGoal = 10000

    var onDataChanged: (() -> Void)?
    
    required init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    public var stepGoal: Int {
        get {
            return dataStore.read(key: .stepGoal) as? Int ?? defaultStepGoal
        }
        set {
            dataStore.write(value: newValue, key: .stepGoal)
            onDataChanged?()
        }
    }
}
