//
//  ClockConnector.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 22.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

class ClockConnector {
    private var server: CLKComplicationServer {
        return CLKComplicationServer.sharedInstance()
    }

    func triggerComplicationUpdate() {
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline(for: complication)
        }
    }

    func getActiveComplicationFamilies() -> [CLKComplicationFamily] {
        return server.activeComplications?.map({ $0.family }) ?? []
    }

    func getAllSupportedComplicationFamilies() -> [CLKComplicationFamily] {
        var families = [CLKComplicationFamily]()
        families.append(.modularSmall)
        families.append(.modularLarge)
        families.append(.utilitarianSmall)
        families.append(.utilitarianSmallFlat)
        families.append(.utilitarianLarge)
        families.append(.circularSmall)
        families.append(.extraLarge)
        families.append(.graphicCorner)
        families.append(.graphicBezel)
        families.append(.graphicCircular)
        families.append(.graphicRectangular)
        return families
    }

    func availableTemplateStyles(for complicationFamily: CLKComplicationFamily) -> [TemplateStyle] {
        return ComplicationStyleManager.complicationStyleManager(for: complicationFamily)?.availableTemplateStyles ?? []
    }

    func availableColorStyles(for complicationFamily: CLKComplicationFamily) -> [ColorStyle] {
        return ComplicationStyleManager.complicationStyleManager(for: complicationFamily)?.availableColorStyles ?? []
    }

    func templateStyle(for complicationFamily: CLKComplicationFamily, id: String?) -> TemplateStyle? {
        return ComplicationStyleManager.complicationStyleManager(for: complicationFamily)?.templateStyle(for: id)
    }

    func colorStyle(for complicationFamily: CLKComplicationFamily, id: String?) -> ColorStyle? {
        return ComplicationStyleManager.complicationStyleManager(for: complicationFamily)?.colorStyle(for: id)
    }
}

extension CLKComplicationFamily {
    var appDisplayName: String {
        switch self {
        case .modularSmall:
            return "Modular Small"
        case .modularLarge:
            return "Modular Large"
        case .utilitarianSmall:
            return "Utilitarian Small"
        case .utilitarianSmallFlat:
            return "Utilitarian Small Flat"
        case .utilitarianLarge:
            return "Utilitarian Large"
        case .circularSmall:
            return "Circluar Small"
        case .extraLarge:
            return "Extra Large"
        case .graphicCorner:
            return "Graphic Corner"
        case .graphicBezel:
            return "Graphic Bezel"
        case .graphicCircular:
            return "Graphic Circluar"
        case .graphicRectangular:
            return "Graphic Rectangular"
        @unknown default:
            return ""
        }
    }
}
