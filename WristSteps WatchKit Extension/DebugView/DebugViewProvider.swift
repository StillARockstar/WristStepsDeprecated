//
//  DebugViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

class DebugViewProvider: ObservableObject {
    @Published var lastBackgroundRefreshString: String
    @Published var lastComplicationTriggerString: String
    @Published var lastComplicationRefreshString: String

    init() {
        lastBackgroundRefreshString = DataCache.shared.lastBackgroundRefresh?.formattedString(format: "yyyy-MM-dd HH:mm:ss") ?? "--"
        lastComplicationTriggerString = DataCache.shared.lastComlicationTrigger?.formattedString(format: "yyyy-MM-dd HH:mm:ss") ?? "--"
        lastComplicationRefreshString = DataCache.shared.lastComplicationRefresh?.formattedString(format: "yyyy-MM-dd HH:mm:ss") ?? "--"
    }
}
