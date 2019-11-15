//
//  SetStyleProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import SwiftUI
import DataCache

struct SetStyleListRowItem {
    let thumbImage: Image
    let title: String
}

class SetStyleProvider: ObservableObject {
    let dataCache: DataCache
    let activeComplicationFamilies: [SetStyleListRowItem]
    let allComplicationFamilies: [SetStyleListRowItem]

    init(dataCache: DataCache) {
        self.dataCache = dataCache
        activeComplicationFamilies = [
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family")
        ]
        allComplicationFamilies = [
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
            SetStyleListRowItem(thumbImage: Image("radialGraph0"), title: "Some Family"),
        ]
    }
}
