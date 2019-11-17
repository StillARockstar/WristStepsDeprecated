//
//  ExtensionDelegate.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import WatchKit
import ClockKit
import DataCache

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    let dataCache = DataCache()
    let clockConnector = ClockConnector()
    private var updateManager: UpdateManager!

    func applicationDidFinishLaunching() {
        dataCache.prepare()
        dataCache.addListener(self, for: [.healthData, .userData, .debugData])

        updateManager = UpdateManager(dataCache: dataCache, dataProvider: DataProvider())
    }

    func applicationDidBecomeActive() {
        updateManager.peformTasks(completion: nil)
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                updateManager.peformTasks {
                    backgroundTask.setTaskCompletedWithSnapshot(false)
                }
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

extension ExtensionDelegate: DataCacheListener {
    func healthDataChanged(_ dataCache: DataCache) {
        clockConnector.triggerComplicationUpdate()
        dataCache.debugData.lastComlicationTrigger = Date()
    }

    func userDataChanged(_ dataCache: DataCache) {
        clockConnector.triggerComplicationUpdate()
        dataCache.debugData.lastComlicationTrigger = Date()
    }

    func debugDataChanged(_ dataCache: DataCache) {

    }
}
