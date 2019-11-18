//
//  SetStyleListProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import SwiftUI
import DataCache

struct SetStyleListRowItem {
    let family: CLKComplicationFamily

    var thumbImage: Image {
        return Image( "radialGraph0")
    }
    var title: String {
        return family.appDisplayName
    }
}

class SetStyleListProvider: ObservableObject {
    let dataCache: DataCache
    let clockConnector: ClockConnector
    @Published var activeComplicationFamilies: [SetStyleListRowItem] = []
    @Published var allComplicationFamilies: [SetStyleListRowItem] = []

    init(dataCache: DataCache, clockConnector: ClockConnector) {
        self.dataCache = dataCache
        self.clockConnector = clockConnector
        buildLists()

        NotificationCenter.default.addObserver(self, selector: #selector(buildLists), name: NSNotification.Name.CLKComplicationServerActiveComplicationsDidChange, object: nil)
    }

    @objc func buildLists() {
        buildActiveList()
        buildAllList()
    }

    private func buildActiveList() {
        activeComplicationFamilies.removeAll()

        for family in clockConnector.getActiveComplicationFamilies() {
            activeComplicationFamilies.append(SetStyleListRowItem(family: family))
        }
    }

    private func buildAllList() {
        allComplicationFamilies.removeAll()

        for family in clockConnector.getAllSupportedComplicationFamilies() {
            allComplicationFamilies.append(SetStyleListRowItem(family: family))
        }
    }
}