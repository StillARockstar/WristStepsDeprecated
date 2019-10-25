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

struct ContentView: View {
    var body: some View {
        HomeView().environmentObject(HomeViewProvider())
    }
}

class HostingController: WKHostingController<ContentView> {
    override var body: ContentView {
        return ContentView()
    }
}
