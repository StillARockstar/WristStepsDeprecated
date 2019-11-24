//
//  ComplicationController.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {

    var oldProvider: OldComplicationProvider = {
        return OldComplicationProvider()
    }()

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.hideOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        oldProvider.dataCache.debugData.lastComplicationRefresh = Date()

        guard let complicationTemplate = getComplicationTemplate(for: complication.family) else {
            handler(nil)
            return
        }
        complicationTemplate.tintColor = .appBlue

        let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: complicationTemplate)
        handler(timelineEntry)
    }

    private func getComplicationTemplate(for family: CLKComplicationFamily) -> CLKComplicationTemplate! {
        switch family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getPercentFloat() / 100.0
            return template
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getPercentFloat() / 100.0
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = CLKTextProvider(format: oldProvider.getPercentLongText())
            template.bodyTextProvider = CLKTextProvider(format: oldProvider.getStepTextShort())
            return template
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getPercentFloat() / 100.0
            return template
        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKTextProvider(format: oldProvider.getPercentLongText())
            return template
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKTextProvider(format: oldProvider.getStepText())
            return template
        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getPercentFloat() / 100.0
            return template
        case .graphicCorner:
            return ComplicationProvider.appComplicationProvider.provider(for: .graphicCorner)?.buildComplication()
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
            template.centerTextProvider = CLKTextProvider(format: oldProvider.getPercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: oldProvider.getPercentFloat() / 100.0)
            return template
        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            template.textProvider = CLKTextProvider(format: oldProvider.getStepStepGoalText())
            template.circularTemplate = getComplicationTemplate(for: .graphicCircular) as! CLKComplicationTemplateGraphicCircular
            return template
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = CLKTextProvider(format: oldProvider.getStepStepGoalText())
            template.body1TextProvider = CLKTextProvider(format: oldProvider.getPercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: oldProvider.getPercentFloat() / 100.0)
            return nil
        @unknown default:
            return nil
        }
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        guard let complicationTemplate = getComplicationSamplteTemplate(for: complication.family) else {
            handler(nil)
            return
        }
        complicationTemplate.tintColor = .appBlue
        handler(complicationTemplate)
    }

    private func getComplicationSamplteTemplate(for family: CLKComplicationFamily) -> CLKComplicationTemplate! {
        switch family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getSamplePercentFloat() / 100.0
            return template
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getSamplePercentFloat() / 100.0
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = CLKTextProvider(format: oldProvider.getSamplePercentLongText())
            template.bodyTextProvider = CLKTextProvider(format: oldProvider.getSampleStepTextShort())
            return template
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getSamplePercentFloat() / 100.0
            return template
        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKTextProvider(format: oldProvider.getSamplePercentLongText())
            return template
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKTextProvider(format: oldProvider.getSampleStepText())
            return template
        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeRingText()
            template.textProvider = CLKTextProvider(format: oldProvider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = oldProvider.getSamplePercentFloat() / 100.0
            return template
        case .graphicCorner:
            return ComplicationProvider.sampleComplicationProvider.provider(for: .graphicCorner)?.buildComplication()
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
            template.centerTextProvider = CLKTextProvider(format: oldProvider.getSamplePercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: oldProvider.getSamplePercentFloat() / 100.0)
            return template
        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            template.textProvider = CLKTextProvider(format: oldProvider.getSampleStepStepGoalText())
            template.circularTemplate = getComplicationSamplteTemplate(for: .graphicCircular) as! CLKComplicationTemplateGraphicCircular
            return template
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = CLKTextProvider(format: oldProvider.getSampleStepStepGoalText())
            template.body1TextProvider = CLKTextProvider(format: oldProvider.getSamplePercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: oldProvider.getSamplePercentFloat() / 100.0)
            return nil
        @unknown default:
            return nil
        }
    }
}
