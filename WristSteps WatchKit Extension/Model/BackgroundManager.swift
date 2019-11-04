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
            DataCache.shared.scheduleRefreshError = error?.localizedDescription
            completion?()
        }
    }

    private func nextScheduleDate() -> Date? {
        let minuteGranuity = 15

        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)

        let floorMinute = minute - (minute % minuteGranuity)
        guard let floorDate = calendar.date(bySettingHour: hour, minute: floorMinute, second: 0, of: now) else { return nil }

        return calendar.date(byAdding: .minute, value: minuteGranuity, to: floorDate)
    }

    func performDataUpdate(completion: (() -> Void)?) {
        if Calendar.current.isDateInToday(DataCache.shared.lastBackgroundRefresh ?? Date()) {
            self.healthConnector.fetchCurrentStepCount(completion: { [weak self] (steps) in
                guard let steps = steps else {
                    DataCache.shared.dataUpdateResult = .noUpdate
                    completion?()
                    return
                }
                DataCache.shared.stepCount = steps
                DataCache.shared.dataUpdateResult = .healthKit
                self?.clockConnector.triggerComplicationUpdate()
                completion?()
            })
        } else {
            DataCache.shared.stepCount = 0
            DataCache.shared.dataUpdateResult = .forcedZero
            self.clockConnector.triggerComplicationUpdate()
            completion?()
        }
    }

    func peformBackgroundTasks(completion: (() -> Void)) {
        let operation1 = BlockOperation { [weak self] in
            let sema = DispatchSemaphore(value: 0)
            self?.performDataUpdate(completion: {
                sema.signal()
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

        DataCache.shared.lastBackgroundRefresh = Date()
        completion()
    }
}
