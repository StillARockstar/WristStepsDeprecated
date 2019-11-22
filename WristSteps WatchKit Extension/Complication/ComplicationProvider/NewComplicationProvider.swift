//
//  NewComplicationProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 19.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

struct TemplateStyle {
    var id: String

    func previewImage(in colorStyle: ColorStyle) -> UIImage? {
        let imageKey = "compl_\(id)_\(colorStyle.id)"
        return UIImage(named: imageKey)
    }
}

struct ColorStyle {
    let id: String
    let previewName: String
    let color: UIColor
}

class NewComplicationProvider {

    var availableTemplateStyles: [TemplateStyle] { fatalError("ComplicationProvider has to be subclassed") }
    var availableColorStyles: [ColorStyle] { fatalError("ComplicationProvider has to be subclassed") }
    var defaultTemplateStyle: TemplateStyle { fatalError("ComplicationProvider has to be subclassed") }
    var defaultColorStyle:ColorStyle { fatalError("ComplicationProvider has to be subclassed") }
    func templateStyle(for id: String?) -> TemplateStyle! { fatalError("ComplicationProvider has to be subclassed") }
    func colorStyle(for id: String?) -> ColorStyle! { fatalError("ComplicationProvider has to be subclassed") }

    static func complictionProvider(for family: CLKComplicationFamily) -> NewComplicationProvider? {
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
            return GraphicCornerComplicationProvider()
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
