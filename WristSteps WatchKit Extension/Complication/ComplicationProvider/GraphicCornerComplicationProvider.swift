//
//  GraphicCornerComplicationProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 19.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import UIKit

class GraphicCornerComplicationProvider: NewComplicationProvider {
    override var availableTemplateStyles: [TemplateStyle] {
        var availableTemplates = [TemplateStyle]()
        availableTemplates.append(TemplateStyle(id: "templ_gc_1", previewImage: UIImage(named: "radialGraph10")!))
        availableTemplates.append(TemplateStyle(id: "templ_gc_2", previewImage: UIImage(named: "radialGraph20")!))
        availableTemplates.append(TemplateStyle(id: "templ_gc_3", previewImage: UIImage(named: "radialGraph30")!))
        availableTemplates.append(TemplateStyle(id: "templ_gc_4", previewImage: UIImage(named: "radialGraph40")!))
        return availableTemplates
    }

    override var availableColorStyles: [ColorStyle] {
        var availableColors = [ColorStyle]()
        availableColors.append(ColorStyle(id: "color_1", previewName: "Blue", color: .appBlue))
        availableColors.append(ColorStyle(id: "color_2", previewName: "Orange", color: .appOrange))
        availableColors.append(ColorStyle(id: "color_3", previewName: "Red", color: .appRed))
        availableColors.append(ColorStyle(id: "color_4", previewName: "Violet", color: .appViolet))
        availableColors.append(ColorStyle(id: "color_5", previewName: "Green", color: .appGreen))
        availableColors.append(ColorStyle(id: "color_6", previewName: "Cyan", color: .appCyan))
        return availableColors
    }
}
