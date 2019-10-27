//
//  BackgroundManager.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 20.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import WatchKit

class BackgroundManager {
    private var healthConnector: HealthConnector
    private var clockConnector: ClockConnector

    init(healthConnector: HealthConnector, clockConnector: ClockConnector) {
        self.healthConnector = healthConnector
        self.clockConnector = clockConnector
    }

    func scheduleNextUpdate(completion: (() -> Void)?) {
        guard let futureDate = self.nextScheduleDate() else { return }
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: futureDate, userInfo: nil) { error in
            if let error = error {
                print(error)
            }
            completion?()
        }
    }

    private func nextScheduleDate() -> Date? {
        let minuteGranuity = 5

        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)

        let floorMinute = minute - (minute % minuteGranuity)
        guard let floorDate = calendar.date(bySettingHour: hour, minute: floorMinute, second: 0, of: now) else { return nil }

        return calendar.date(byAdding: .minute, value: minuteGranuity, to: floorDate)
    }

    func peformBackgroundTasks(completion: (() -> Void)) {
        DataCache.shared.lastBackgroundRefresh = Date()
        
        let operation1 = BlockOperation { [weak self] in
            let sema = DispatchSemaphore(value: 0)
            self?.healthConnector.fetchCurrentStepCount(completion: { (steps) in
                guard let steps = steps else { return }
                DataCache.shared.stepCount = steps
                self?.clockConnector.triggerComplicationUpdate()
            })
            sema.wait()
        }
        let operation2 = BlockOperation { [weak self] in
            let sema = DispatchSemaphore(value: 0)
            self?.scheduleNextUpdate {
                sema.signal()
            }
            sema.wait()
        }

        let loadingQueue = OperationQueue()
        loadingQueue.addOperation(operation1)
        loadingQueue.addOperation(operation2)
        loadingQueue.waitUntilAllOperationsAreFinished()

        completion()
    }
}
