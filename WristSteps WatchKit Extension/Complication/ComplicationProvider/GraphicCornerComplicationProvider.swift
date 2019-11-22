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
        availableTemplates.append(TemplateStyle(id: "templ_gc_1"))
        availableTemplates.append(TemplateStyle(id: "templ_gc_2"))
        availableTemplates.append(TemplateStyle(id: "templ_gc_3"))
        availableTemplates.append(TemplateStyle(id: "templ_gc_4"))
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

    override var defaultTemplateStyle: TemplateStyle {
        return availableTemplateStyles[0]
    }

    override var defaultColorStyle: ColorStyle {
        return availableColorStyles[0]
    }

    override func templateStyle(for id: String?) -> TemplateStyle {
        return availableTemplateStyles.first(where: { $0.id == id }) ?? defaultTemplateStyle
    }

    override func colorStyle(for id: String?) -> ColorStyle {
        return availableColorStyles.first(where: { $0.id == id }) ?? defaultColorStyle
    }
}
