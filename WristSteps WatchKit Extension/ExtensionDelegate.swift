//
//  ExtensionDelegate.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    private var backgroundManager: BackgroundManager!
    private var clockConnector: ClockConnector!

    func applicationDidFinishLaunching() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateComplications), name: DataCacheValueUpdatedNotificationName, object: nil)

        let healthConnector = HealthConnector()

        healthConnector.requestAuthorization { _ in
            healthConnector.fetchCurrentStepCount { (steps) in
                guard let steps = steps else { return }
                DataCache.shared.stepCount = steps
            }
        }

        backgroundManager = BackgroundManager(healthConnector: healthConnector)
        backgroundManager.scheduleNextUpdate(completion: nil)

        clockConnector = ClockConnector()
    }

    @objc func updateComplications() {
        clockConnector.triggerComplicationUpdate()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundManager.peformBackgroundTasks {
                    backgroundTask.setTaskCompletedWithSnapshot(false)
                }
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
