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

    func fetchCurrentStepCount(completion: @escaping ((Int?, String?) -> Void)) {
        let endDate = Date()
        let startDate = Calendar.current.startOfDay(for: endDate)

        pedometer.queryPedometerData(from: startDate, to: endDate) { (pedometerData, error) in
            guard let pedometerData = pedometerData else {
                completion(nil, error.debugDescription)
                return
            }
            completion(pedometerData.numberOfSteps.intValue, nil)
        }
    }
}
