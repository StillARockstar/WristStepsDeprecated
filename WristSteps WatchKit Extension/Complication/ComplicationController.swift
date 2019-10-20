//
//  ComplicationController.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.hideOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        switch complication.family {
        case .graphicCorner:
            let complication = CLKComplicationTemplateGraphicCornerTextImage()
            complication.imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named:"radialGraph71")!)
            complication.textProvider = CLKTextProvider(format: "%d steps", 1000)

            let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: complication)
            handler(timelineEntry)
        default:
            handler(nil)
        }
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        switch complication.family {
        case .graphicCorner:
            let complication = CLKComplicationTemplateGraphicCornerTextImage()
            complication.imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named:"radialGraph71")!)
            complication.textProvider = CLKTextProvider(format: "%d steps", 1000)
            handler(complication)
        default:
            handler(nil)
        }
    }
    
}
