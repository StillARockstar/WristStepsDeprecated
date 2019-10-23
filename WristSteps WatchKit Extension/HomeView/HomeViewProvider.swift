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

    @Published var steps = 0
    @Published var stepPercent = 0
    @Published var stepGoal = 10000

    init(connector: HealthConnector) {
        self.connector = connector
        connector.requestAuthorization { [weak self] _ in
            self?.updateCurrentStepCount()
            self?.registerObserver()
        }
    }

    private func updateCurrentStepCount() {
        connector.fetchCurrentStepCount { [weak self] (steps) in
            self?.handle(stepCount: steps)
        }
    }

    private func registerObserver() {
        connector.registerObserver { [weak self] (steps) in
            self?.handle(stepCount: steps)
        }
    }

    private func handle(stepCount: Int?) {
        DispatchQueue.main.async {
            self.steps = stepCount ?? 0
            let calculatedPercent = Double(self.steps) / Double(self.stepGoal)
            self.stepPercent = Int(calculatedPercent * 100)
        }
    }
}
