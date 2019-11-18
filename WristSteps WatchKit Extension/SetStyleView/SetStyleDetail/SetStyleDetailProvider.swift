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
    let family: CLKComplicationFamily

    private(set) var availableStyles: [Image] = []
    private(set) var availableColors: [String] = []

    @Published var selectedStyle: Int = 0
    @Published var selectedColor: Int = 0

    init(dataCache: DataCache, family: CLKComplicationFamily) {
        self.dataCache = dataCache
        self.family = family

        buildStylePicker()
        buildColorPicker()
    }

    private func buildStylePicker() {
        availableStyles.removeAll()
        availableStyles = [Image("radialGraph0"), Image("radialGraph10"), Image("radialGraph20"), Image("radialGraph30"), Image("radialGraph40")]
    }

    private func buildColorPicker() {
        availableColors.removeAll()
        availableColors = ["Orange", "Green", "Red", "Blue", "Cyan"]
    }

    func commitCurrentStyleConfiguration() {
        print("Selected Style: \(selectedStyle)")
        print("Selected Color: \(selectedColor)")
    }
}
