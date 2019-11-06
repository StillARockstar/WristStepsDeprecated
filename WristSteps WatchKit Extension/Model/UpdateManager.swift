//
//  UpdateManager.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 20.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import WatchKit
import DataCache

class UpdateManager {
    private let dataCache: DataCache
    private let dataProvider: DataProvider

    init(dataCache: DataCache, dataProvider: DataProvider) {
        self.dataCache = dataCache
        self.dataProvider = dataProvider
    }

    private func scheduleNextUpdate(completion: (() -> Void)?) {
        guard let futureDate = self.nextScheduleDate() else { return }
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: futureDate, userInfo: nil) { [weak self] error in
            self?.dataCache.debugData.scheduleRefreshError = error?.localizedDescription
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

    private func performDataUpdate(completion: (() -> Void)?) {
        self.dataProvider.fetchCurrentStepCount(completion: { [weak self] (steps, errorDescription) in
            if let errorDescription = errorDescription {
                self?.dataCache.debugData.pedometerGetStepCountError = errorDescription
            }
            guard let steps = steps else {
                self?.dataCache.debugData.dataUpdateResult = .noUpdate
                completion?()
                return
            }
            self?.dataCache.healthData.stepCount = steps
            self?.dataCache.debugData.dataUpdateResult = .pedometer
            completion?()
        })
    }

    func peformTasks(completion: (() -> Void)?) {
        let operation1 = BlockOperation { [weak self] in
            let sema = DispatchSemaphore(value: 0)
            self?.performDataUpdate {
                sema.signal()
            }
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

        self.dataCache.debugData.lastBackgroundRefresh = Date()
        completion?()
    }
}
