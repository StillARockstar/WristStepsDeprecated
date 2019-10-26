//
//  ComplicationController.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {

    var provider: ComplicationProvider = {
        return ComplicationProvider()
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
        DataCache.shared.lastComplicationRefresh = Date()

        guard let complicationTemplate = getComplicationTemplate(for: complication.family) else {
            handler(nil)
            return
        }

        let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: complicationTemplate)
        handler(timelineEntry)
    }

    private func getComplicationTemplate(for family: CLKComplicationFamily) -> CLKComplicationTemplate! {
        switch family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKTextProvider(format: provider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getPercentFloat() / 100.0
            return template
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKTextProvider(format: provider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getPercentFloat() / 100.0
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = CLKTextProvider(format: provider.getPercentText())
            template.bodyTextProvider = CLKTextProvider(format: provider.getStepText())
            return template
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKTextProvider(format: provider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getPercentFloat() / 100.0
            return template
        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKTextProvider(format: provider.getPercentText())
            return template
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKTextProvider(format: provider.getStepText())
            return template
        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeRingText()
            template.textProvider = CLKTextProvider(format: provider.getPercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getPercentFloat() / 100.0
            return template
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerTextImage()
            template.imageProvider = CLKFullColorImageProvider(fullColorImage: provider.getPercentImage())
            template.textProvider = CLKTextProvider(format: provider.getStepText())
            return template
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
            template.centerTextProvider = CLKTextProvider(format: provider.getPercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: provider.getPercentFloat() / 100.0)
            return template
        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            template.textProvider = CLKTextProvider(format: provider.getStepStepGoalText())
            template.circularTemplate = getComplicationTemplate(for: .graphicCircular) as! CLKComplicationTemplateGraphicCircular
            return template
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = CLKTextProvider(format: provider.getStepStepGoalText())
            template.body1TextProvider = CLKTextProvider(format: provider.getPercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: provider.getPercentFloat() / 100.0)
            return nil
        @unknown default:
            return nil
        }
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        switch complication.family {
        case .graphicCorner:
            let complication = CLKComplicationTemplateGraphicCornerTextImage()
            complication.imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named:"radialGraph10")!)
            complication.textProvider = CLKTextProvider(format: "%d steps", 1000)
            handler(complication)
        default:
            handler(nil)
        }
    }

    private func getComplicationSamplteTemplate(for family: CLKComplicationFamily) -> CLKComplicationTemplate! {
        switch family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getSamplePercentFloat() / 100.0
            return template
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getSamplePercentFloat() / 100.0
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.bodyTextProvider = CLKTextProvider(format: provider.getSampleStepText())
            return template
        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallRingText()
            template.textProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getSamplePercentFloat() / 100.0
            return template
        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = CLKTextProvider(format: provider.getSamplePercentText())
            return template
        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKTextProvider(format: provider.getSampleStepText())
            return template
        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeRingText()
            template.textProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.ringStyle = .closed
            template.fillFraction = provider.getSamplePercentFloat() / 100.0
            return template
        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerTextImage()
            template.imageProvider = CLKFullColorImageProvider(fullColorImage: provider.getSamplePercentImage())
            template.textProvider = CLKTextProvider(format: provider.getSampleStepText())
            return template
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeText()
            template.centerTextProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: provider.getSamplePercentFloat() / 100.0)
            return template
        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            template.textProvider = CLKTextProvider(format: provider.getSampleStepStepGoalText())
            template.circularTemplate = getComplicationSamplteTemplate(for: .graphicCircular) as! CLKComplicationTemplateGraphicCircular
            return template
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = CLKTextProvider(format: provider.getSampleStepStepGoalText())
            template.body1TextProvider = CLKTextProvider(format: provider.getSamplePercentText())
            template.gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .appBlue, fillFraction: provider.getSamplePercentFloat() / 100.0)
            return nil
        @unknown default:
            return nil
        }
    }
}
