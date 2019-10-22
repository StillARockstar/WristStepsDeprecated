//
//  ClockConnector.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 22.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

class ClockConnector {
    private var server: CLKComplicationServer {
        return CLKComplicationServer.sharedInstance()
    }

    func updateComplicationStepCount(newValue: Int) {
        KeyValueStore.shared.store(value: newValue, key: .stepCount)
    }

    func triggerComplicationUpdate() {
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline(for: complication)
        }
    }
}
