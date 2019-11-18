//
//  DebugViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import DataCache

class DebugViewProvider: ObservableObject {
    let dataCache: DataCache

    @Published var lastBackgroundRefreshString: String = "--"
    @Published var lastDataRefreshString: String = "--"
    @Published var lastComplicationTriggerString: String = "--"
    @Published var lastComplicationRefreshString: String = "--"
    @Published var stepCountUpdateResultString: String = "--"
    @Published var scheduleRefreshErrorString: String = "--"
    @Published var pedometerGetStepCountErrorString: String = "--"

    init(dataCache: DataCache) {
        self.dataCache = dataCache
    }

    func onViewAppear() {
        self.dataCache.addListener(self, for: [.healthData, .userData])
        updateViewData()
    }

    func onViewDisappear() {
        self.dataCache.removeListener(self)
    }

    private func updateViewData() {
        DispatchQueue.main.async {
            let debugDateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.lastBackgroundRefreshString = self.dataCache.debugData.lastBackgroundRefresh?.formattedString(format: debugDateFormat) ?? "--"
            self.lastDataRefreshString = self.dataCache.debugData.lastDataRefresh?.formattedString(format: debugDateFormat) ?? "--"
            self.lastComplicationTriggerString = self.dataCache.debugData.lastComlicationTrigger?.formattedString(format: debugDateFormat) ?? "--"
            self.lastComplicationRefreshString = self.dataCache.debugData.lastComplicationRefresh?.formattedString(format: debugDateFormat) ?? "--"
            self.stepCountUpdateResultString = self.dataCache.debugData.dataUpdateResult?.rawValue ?? "--"
            self.scheduleRefreshErrorString = self.dataCache.debugData.scheduleRefreshError ?? "--"
            self.pedometerGetStepCountErrorString = self.dataCache.debugData.pedometerGetStepCountError ?? "--"
        }
    }
}


extension DebugViewProvider: DataCacheListener {
    func healthDataChanged(_ dataCache: DataCache) {

    }

    func userDataChanged(_ dataCache: DataCache) {

    }

    func debugDataChanged(_ dataCache: DataCache) {
        updateViewData()
    }
}
