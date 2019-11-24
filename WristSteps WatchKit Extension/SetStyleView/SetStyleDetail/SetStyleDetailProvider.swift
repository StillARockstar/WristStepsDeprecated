//
//  SetStyleDetailProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 18.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import SwiftUI
import ClockKit
import DataCache

class SetStyleDetailProvider: ObservableObject {
    let dataCache: DataCache
    let clockConnector: ClockConnector
    let family: CLKComplicationFamily

    private(set) var availableStylePreviews: [Image] = []
    private(set) var availableColorNames: [String] = []

    @Published var selectedStyleIndex: Int = 0
    @Published var selectedColorIndex: Int = 0 {
        didSet {
            print("Current selected: \(selectedColorIndex)")
            buildStylePicker()
        }
    }

    init(dataCache: DataCache, clockConnector: ClockConnector, family: CLKComplicationFamily) {
        self.dataCache = dataCache
        self.clockConnector = clockConnector
        self.family = family

        buildStylePicker()
        buildColorPicker()
    }

    private func buildStylePicker() {
        availableStylePreviews = clockConnector.availableTemplateStyles(for: family).map() { item in
            let colorStyle = clockConnector.availableColorStyles(for: family)[selectedColorIndex]
            return Image(uiImage: item.previewImage(in: colorStyle) ?? UIImage())
        }
    }

    private func buildColorPicker() {
        availableColorNames = clockConnector.availableColorStyles(for: family).map({ $0.previewName })
    }

    func commitCurrentStyleConfiguration() {
        let selectedStyle = clockConnector.availableTemplateStyles(for: family)[selectedStyleIndex]
        let selectedColor = clockConnector.availableColorStyles(for: family)[selectedColorIndex]

        dataCache.userData.setSelectedTemplateStyleId(for: family, templateStyleId: selectedStyle.id)
        dataCache.userData.setSelectedColorStyleId(for: family, colorStyleId: selectedColor.id)
        
        clockConnector.triggerComplicationUpdate()
        print("Selected Style: \(selectedStyle.id)")
        print("Selected Color: \(selectedColor.id)")
    }
}
