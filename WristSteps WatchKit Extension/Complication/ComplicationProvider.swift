//
//  ComplicationProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit
import DataCache

protocol ComplicationBuilder {
    init(dataProvider: ComplicationDataProvider)
    func buildComplication() -> CLKComplicationTemplate?
}

class ComplicationProvider {
    static var appComplicationProvider: ComplicationProvider = {
        let dataCache = AppDataCache()
        dataCache.prepare()
        return ComplicationProvider(dataCache: dataCache)
    }()

    static var sampleComplicationProvider: ComplicationProvider = {
        let dataCache = SampleDataCache()
        dataCache.prepare()
        return ComplicationProvider(dataCache: dataCache)
    }()

    private let dataProvider: ComplicationDataProvider

    init(dataCache: DataCache) {
        self.dataProvider = ComplicationDataProvider(dataCache: dataCache)
    }

    func provider(for family: CLKComplicationFamily) -> ComplicationBuilder? {
        switch family {
        case .circularSmall:
            return nil
        case .modularSmall:
            return nil
        case .modularLarge:
            return nil
        case .utilitarianSmall:
            return nil
        case .utilitarianSmallFlat:
            return nil
        case .utilitarianLarge:
            return nil
        case .extraLarge:
            return nil
        case .graphicCorner:
            return GraphicCornerComplicationBuilder(dataProvider: dataProvider)
        case .graphicCircular:
            return nil
        case .graphicBezel:
            return nil
        case .graphicRectangular:
            return nil
        @unknown default:
            return nil
        }
    }
}
