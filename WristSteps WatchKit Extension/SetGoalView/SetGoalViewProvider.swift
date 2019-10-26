//
//  SetGoalViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class SetGoalProvider: ObservableObject {
    @Published var stepGoal: Double = 0

    init(initialGoal: Int) {
        stepGoal = Double(initialGoal)
    }

    func commitStepGoal() {
        DataCache.shared.stepGoal = Int(stepGoal)
    }
}
