//
//  DataProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import CoreMotion

class DataProvider {
    private let pedometer = CMPedometer()

    init() {
    }

    func fetchCurrentStepCount(completion: @escaping ((Int?) -> Void)) {
        let endDate = Date()
        let startDate = Calendar.current.startOfDay(for: endDate)

        pedometer.queryPedometerData(from: startDate, to: endDate) { (pedometerData, error) in
            guard let pedometerData = pedometerData else {
                DataCache.shared.pedometerGetStepCountError = error.debugDescription
                completion(nil)
                return
            }
            completion(pedometerData.numberOfSteps.intValue)
        }
    }
}
