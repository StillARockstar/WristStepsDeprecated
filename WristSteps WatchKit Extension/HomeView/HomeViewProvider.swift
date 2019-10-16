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

    init(connector: HealthConnector) {
        self.connector = connector
        connector.requestAuthorization { [weak self] _ in
            self?.updateCurrentStepCount()
        }
    }

    private func updateCurrentStepCount() {
        connector.fetchCurrentStepCount { [weak self] (steps) in
            DispatchQueue.main.async {
                guard let steps = steps else {
                    self?.steps = 0
                    return
                }
                self?.steps = steps
            }
        }
    }
}
