//
//  DebugView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct DebugView: View {
    @EnvironmentObject var provider: DebugViewProvider

    var body: some View {
        ScrollView {
            VStack {
                headlineValueView(headline: "Background refresh",
                                  value: provider.lastBackgroundRefreshString)
                headlineValueView(headline: "Complication trigger",
                                  value: provider.lastComplicationTriggerString)
                headlineValueView(headline: "Complication refresh",
                                  value: provider.lastComplicationRefreshString)
                headlineValueView(headline: "Step update result",
                                  value: provider.stepCountUpdateResultString)
                headlineValueView(headline: "Schedule error",
                                  value: provider.scheduleRefreshErrorString)
                headlineValueView(headline: "Get stepcount error",
                                  value: provider.pedometerGetStepCountErrorString)
            }
        }
        .onAppear() {
            self.provider.onViewAppear()
        }
        .onDisappear() {
            self.provider.onViewDisappear()
        }
        .navigationBarTitle("Debug")
    }

    func headlineValueView(headline: String, value: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(headline)
                Spacer()
            }
            HStack {
                Text(value)
                    .lineLimit(nil)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                Spacer()
            }
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView().environmentObject(DebugViewProvider(dataCache: DataCache()))
    }
}
