//
//  HomeViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class HomeViewProvider: ObservableObject {
    @Published var steps = 0
    @Published var stepPercent = 0
    @Published var stepGoal = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewData), name: DataCacheValueUpdatedNotificationName, object: nil)
        updateViewData()
    }

    @objc func updateViewData() {
        let newStepCount = DataCache.shared.stepCount
        let newStepGoal = DataCache.shared.stepGoal
        self.handle(stepCount: newStepCount, stepGoal: newStepGoal)
    }

    private func handle(stepCount: Int, stepGoal: Int) {
        DispatchQueue.main.async {
            self.steps = stepCount
            self.stepGoal = stepGoal

            let calculatedPercent = Double(self.steps) / Double(self.stepGoal)
            self.stepPercent = Int(calculatedPercent * 100)
        }
    }
}
