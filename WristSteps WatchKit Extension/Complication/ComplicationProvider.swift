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

    func getStepText() -> String {
        return DataCache.shared.stepCount.formattedString + " steps"
    }

    func getSampleStepText() -> String {
        return 5000.formattedString + " steps"
    }

    func getPercentFloat() -> Float {
        let stepCount = DataCache.shared.stepCount
        let stepGoal = DataCache.shared.stepGoal

        let calculatedPercent = Double(stepCount) / Double(stepGoal)
        let stepPercent = Int(calculatedPercent * 100)

        return Float(stepPercent)
    }

    func getSamplePercentFloat() -> Float {
        return 50.0
    }

    func getPercentText() -> String {
        return "\(Int(getPercentFloat()))%"
    }

    func getSamplePercentText() -> String {
        return "50%"
    }

    func getPercentImage() -> UIImage {
        var stepPercent = Int(getPercentFloat())

        if stepPercent > 100 {
            stepPercent = 100
        }

        return UIImage(named:"radialGraph\(stepPercent)")!
    }

    func getSamplePercentImage() -> UIImage {
        return UIImage(named:"radialGraph50")!
    }

    func getStepStepGoalText() -> String {
        let stepCount = DataCache.shared.stepCount
        let stepGoal = DataCache.shared.stepGoal
        return "\(stepCount) / \(stepGoal)"
    }

    func getSampleStepStepGoalText() -> String {
        return "\(5000.formattedString) / \(10000.formattedString)"
    }
}
