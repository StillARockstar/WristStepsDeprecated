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

    @Published var previewImage: UIImage = UIImage()

    private(set) var availableColorNames: [String] = []
    @Published var selectedColorIndex: Int = 0 {
        didSet {
            updatePreviewImage()
        }
    }

    init(dataCache: DataCache, clockConnector: ClockConnector, family: CLKComplicationFamily) {
        self.dataCache = dataCache
        self.clockConnector = clockConnector
        self.family = family

        buildColorPicker()
        updatePreviewImage()
    }

    private func updatePreviewImage() {
        let templateId = dataCache.userData.getSelectedTemplateStyleId(for: family)
        let colorId = clockConnector.availableColorStyles(for: family)[selectedColorIndex].id

        guard let templateStyle = clockConnector.templateStyle(for: family, id: templateId) else { return }
        guard let colorStyle = clockConnector.colorStyle(for: family, id: colorId) else { return }

        previewImage = templateStyle.previewImage(in: colorStyle) ?? UIImage()
    }

    private func buildColorPicker() {
        availableColorNames = clockConnector.availableColorStyles(for: family).map({ $0.previewName })

        let selectedColorStyleId = dataCache.userData.getSelectedColorStyleId(for: family)
        let selectedIndex = clockConnector.availableColorStyles(for: family).firstIndex(where: { $0.id == selectedColorStyleId })
        selectedColorIndex = selectedIndex ?? 0
    }

    func commitCurrentStyleConfiguration() {
        let selectedColor = clockConnector.availableColorStyles(for: family)[selectedColorIndex]
        dataCache.userData.setSelectedColorStyleId(for: family, colorStyleId: selectedColor.id)
        clockConnector.triggerComplicationUpdate()
    }
}
