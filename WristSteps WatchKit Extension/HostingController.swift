//
//  HostingController.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import DataCache

struct ContentView: View {
    private var dataCache: DataCache {
        return (WKExtension.shared().delegate as! ExtensionDelegate).dataCache
    }

    private var clockConnector: ClockConnector {
        return (WKExtension.shared().delegate as! ExtensionDelegate).clockConnector
    }

    var body: some View {
        HomeView().environmentObject(HomeViewProvider(dataCache: dataCache, clockConnector: clockConnector))
    }
}

class HostingController: WKHostingController<ContentView> {
    override var body: ContentView {
        return ContentView()
    }
}
