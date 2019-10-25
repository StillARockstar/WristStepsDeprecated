//
//  ComplicationManager.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 20.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import UIKit

class ComplicationProvider {

    func getText() -> String {
        return DataCache.shared.stepCount.formattedString + " steps"
    }

    func getImage() -> UIImage {
        let calculatedPercent = Double(DataCache.shared.stepCount) / Double(10000)
        var stepPercent = Int(calculatedPercent * 100)

        if stepPercent > 100 {
            stepPercent = 100
        }

        return UIImage(named:"radialGraph\(stepPercent)")!
    }
}
