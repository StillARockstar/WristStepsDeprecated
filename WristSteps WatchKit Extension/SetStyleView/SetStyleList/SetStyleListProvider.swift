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
    let thumbImage: Image
    let title: String
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
        activeComplicationFamilies = buildList(for: clockConnector.getActiveComplicationFamilies())
    }

    private func buildAllList() {
        allComplicationFamilies = buildList(for: clockConnector.getAllSupportedComplicationFamilies())
    }

    private func buildList(for families: [CLKComplicationFamily]) -> [SetStyleListRowItem] {
        var itemList = [SetStyleListRowItem]()

        for family in families {
            let templateId = dataCache.userData.getSelectedTemplateStyleId(for: family)
            let colorId = dataCache.userData.getSelectedColorStyleId(for: family)

            guard let templateStyle = clockConnector.templateStyle(for: family, id: templateId) else { continue }
            guard let colorStyle = clockConnector.colorStyle(for: family, id: colorId) else { continue }
            
            let thumbImage = Image(uiImage: templateStyle.previewImage(in: colorStyle) ?? UIImage())
            let item = SetStyleListRowItem(family: family, thumbImage: thumbImage, title: family.appDisplayName)
            itemList.append(item)
        }

        return itemList
    }
}
