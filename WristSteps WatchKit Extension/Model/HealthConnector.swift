//
//  HealthConnector.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import HealthKit

class HealthConnector {
    static var `default`: HealthConnector = {
        return HealthConnector()
    }()

    private let healthStore: HKHealthStore
    private let stepCountType: HKQuantityType
    private let dataToRead: Set<HKQuantityType>
    private var observerQuery: Int?

    init() {
        healthStore = HKHealthStore()
        stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        dataToRead = Set([stepCountType])
    }

    func requestAuthorization(completion: ((Bool) -> Void)?) {
        healthStore.requestAuthorization(toShare: nil, read: dataToRead) { (succes, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            completion?(succes)
        }
    }

    func fetchCurrentStepCount(completion: @escaping ((Int?) -> Void)) {
        let endDate = Date()
        let startDate = Calendar.current.startOfDay(for: endDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        var interval = DateComponents()
        interval.day = 1

        let stepCountQuery = HKStatisticsCollectionQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: [.cumulativeSum],
            anchorDate: startDate,
            intervalComponents: interval)

        stepCountQuery.initialResultsHandler = { query, results, error in
            guard let results = results else {
                completion(nil)
                return
            }
            guard let firstStatistic = results.statistics().first else {
                completion(nil)
                return
            }
            guard let doubleSteps = firstStatistic.sumQuantity()?.doubleValue(for: HKUnit.count()) else {
                completion(nil)
                return
            }
            completion(Int(doubleSteps))
        }

        healthStore.execute(stepCountQuery)
    }
}
