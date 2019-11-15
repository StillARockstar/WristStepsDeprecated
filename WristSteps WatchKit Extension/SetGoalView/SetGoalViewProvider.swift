//
//  SetGoalViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import DataCache

class SetGoalProvider: ObservableObject {
    let dataCache: DataCache

    @Published var stepGoal: Double = 0

    init(dataCache: DataCache) {
        self.dataCache = dataCache
        self.stepGoal = Double(dataCache.userData.stepGoal)
    }

    func commitStepGoal() {
        dataCache.userData.stepGoal = Int(stepGoal)
    }
}
