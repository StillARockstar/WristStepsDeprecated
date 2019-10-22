//
//  ComplicationManager.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 20.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

class ComplicationProvider {
    var connector: HealthConnector!

    private var server: CLKComplicationServer {
        return CLKComplicationServer.sharedInstance()
    }

    var currentStepCount: Int {
        return readStepCount()
    }

    func triggerComplicationUpdates() {
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline(for: complication)
        }
    }

    func updateStepCount(completion: @escaping (() -> Void)) {
        connector.fetchCurrentStepCount { [weak self] (steps) in
            if let steps = steps {
                self?.storeStepCount(newValue: steps)
            }
            completion()
        }
    }
}

private extension ComplicationProvider {
    private var stepCountKey: String { return "currentStepCount" }

    func storeStepCount(newValue: Int) {
        UserDefaults.standard.set(newValue, forKey: stepCountKey)
    }

    func readStepCount() -> Int {
        return UserDefaults.standard.integer(forKey: stepCountKey)
    }
}
