//
//  SetGoalViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class SetGoalProvider: ObservableObject {
    @Published var stepGoal = 0

    init() {
        updateViewData()
    }

    @objc func updateViewData() {
        let newStepGoal = DataCache.shared.stepGoal
        self.handle(stepGoal: newStepGoal)
    }

    private func handle(stepGoal: Int) {
        DispatchQueue.main.async {
            self.stepGoal = stepGoal
        }
    }
}
