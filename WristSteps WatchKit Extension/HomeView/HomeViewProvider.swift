//
//  HomeViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class HomeViewProvider: ObservableObject {
    private let connector: HealthConnector
    private let stepGoal = 10000

    @Published var steps = 0
    @Published var stepPercent = 0

    init(connector: HealthConnector) {
        self.connector = connector
        connector.requestAuthorization { [weak self] _ in
            self?.updateCurrentStepCount()
        }
    }

    private func updateCurrentStepCount() {
        connector.fetchCurrentStepCount { [weak self] (steps) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.steps = steps ?? 0
                let calculatedPercent = Double(self.steps) / Double(self.stepGoal)
                self.stepPercent = Int(calculatedPercent * 100)
            }
        }
    }
}
