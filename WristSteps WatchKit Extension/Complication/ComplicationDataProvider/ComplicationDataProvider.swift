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
    let dataCache: DataCache

    private var sampleStepCount: Int {
        return 5000
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

    func getSteps(in style: ComplicationDataProviderTextStyle, colorStyle: ColorStyle) -> CLKTextProvider {
        var textProvider: CLKTextProvider!

        switch style {
        case .long:
            textProvider = CLKTextProvider(format: sampleStepCount.formattedString + " steps")
        case .short:
            textProvider = CLKTextProvider(format: sampleStepCount.formattedString)
        case .shortened:
            textProvider = CLKTextProvider(format: sampleStepCount.kFormattedString)
        }

        textProvider.tintColor = colorStyle.color
        return textProvider
    }

    func getPercent(in style: ComplicationDataProviderTextStyle, colorStyle: ColorStyle) -> CLKTextProvider {
        var textProvider: CLKTextProvider!
        switch style {
        case .long:
            textProvider = CLKTextProvider(format: percentInt.formattedString + " percent")
        case .short:
            textProvider = CLKTextProvider(format: percentInt.formattedString + "%%")
        case .shortened:
            textProvider = CLKTextProvider(format: percentInt.kFormattedString)
        }

        textProvider.tintColor = colorStyle.color
        return textProvider
    }

    func getFullColorImage(in style: ComplicationDataProviderImageStyle, colorStyle: ColorStyle) -> CLKFullColorImageProvider {
        switch style {
        case .circleGraph:
            var percentToDisplay = percentInt
            if percentToDisplay > 100 {
                percentToDisplay = percentToDisplay % 100 + 100
            }

            return CLKFullColorImageProvider(fullColorImage: UIImage(named:"radialGraph_\(colorStyle.id)_\(percentToDisplay)")!)
        }
    }
}
