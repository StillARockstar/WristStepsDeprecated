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
    @Published var stepGoal = 10000

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentStepCount), name: DataCacheValueUpdatedNotificationName, object: nil)
        updateCurrentStepCount()
    }

    @objc func updateCurrentStepCount() {
        let newStepCount = DataCache.shared.stepCount
        self.handle(stepCount: newStepCount)
    }

    private func handle(stepCount: Int?) {
        DispatchQueue.main.async {
            self.steps = stepCount ?? 0
            let calculatedPercent = Double(self.steps) / Double(self.stepGoal)
            self.stepPercent = Int(calculatedPercent * 100)
        }
    }
}
