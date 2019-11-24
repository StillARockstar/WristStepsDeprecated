//
//  GraphicCornerComplicationProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit
import DataCache

class GraphicCornerComplicationBuilder: ComplicationBuilder {
    private let dataProvider: ComplicationDataProvider

    required init(dataProvider: ComplicationDataProvider) {
        self.dataProvider = dataProvider
    }

    func buildComplication() -> CLKComplicationTemplate? {
        let templateStyleId = dataProvider.dataCache.userData.getSelectedTemplateStyleId(for: .graphicCorner)
        guard let templateStyle =
            ComplicationStyleManager.complicationStyleManager(for: .graphicCorner)?.templateStyle(for: templateStyleId) else { return nil }

        let colorStyleId = dataProvider.dataCache.userData.getSelectedColorStyleId(for: .graphicCorner)
        guard let colorStyle =
            ComplicationStyleManager.complicationStyleManager(for: .graphicCorner)?.colorStyle(for: colorStyleId) else { return nil }

        switch templateStyle.id {
        case "templ_gc_1":
            let complicationTemplate = CLKComplicationTemplateGraphicCornerTextImage()
            complicationTemplate.textProvider = dataProvider.getSteps(in: .long, colorStyle: colorStyle)
            complicationTemplate.imageProvider = dataProvider.getFullColorImage(in: .circleGraph, colorStyle: colorStyle)
            complicationTemplate.tintColor = colorStyle.color
            return complicationTemplate
        default:
            return nil
        }
    }
}
