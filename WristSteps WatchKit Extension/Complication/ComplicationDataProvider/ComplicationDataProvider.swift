//
//  ComplicationDataProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit
import DataCache

enum ComplicationDataProviderTextStyle {
    case shortened
    case short
    case long
}

enum ComplicationDataProviderImageStyle {
    case circleGraph
}

class ComplicationDataProvider {
    private let dataCache: DataCache

    private var sampleStepCount: Int {
        return dataCache.healthData.stepCount
    }
    private var sampleStepGoal: Int {
        return dataCache.userData.stepGoal
    }
    private var percentFloat: Float {
        return Float(sampleStepCount) / Float(sampleStepGoal)
    }
    private var percentInt: Int {
        return Int(percentFloat * 100)
    }

    init(dataCache: DataCache) {
        self.dataCache = dataCache
    }

    func getSteps(in style: ComplicationDataProviderTextStyle) -> CLKTextProvider {
        switch style {
        case .long:
            return CLKTextProvider(format: sampleStepCount.formattedString + " steps")
        case .short:
            return CLKTextProvider(format: sampleStepCount.formattedString)
        case .shortened:
            return CLKTextProvider(format: sampleStepCount.kFormattedString)
        }
    }

    func getStepGoal(in style: ComplicationDataProviderTextStyle) -> CLKTextProvider {
        switch style {
        case .long:
            return CLKTextProvider(format: sampleStepGoal.formattedString + " steps")
        case .short:
            return CLKTextProvider(format: sampleStepGoal.formattedString)
        case .shortened:
            return CLKTextProvider(format: sampleStepGoal.kFormattedString)
        }
    }

    func getPercent(in style: ComplicationDataProviderTextStyle) -> CLKTextProvider {
        switch style {
        case .long:
            return CLKTextProvider(format: percentInt.formattedString + " percent")
        case .short:
            return CLKTextProvider(format: percentInt.formattedString + "%%")
        case .shortened:
            return CLKTextProvider(format: percentInt.kFormattedString)
        }
    }

    func getImage(in style: ComplicationDataProviderImageStyle) -> CLKImageProvider {
        switch style {
        case .circleGraph:
            var percentToDisplay = percentInt
            if percentToDisplay > 100 {
                percentToDisplay = percentToDisplay % 100 + 100
            }

            return CLKImageProvider(onePieceImage: UIImage(named:"radialGraph\(percentToDisplay)")!)
        }
    }
}
