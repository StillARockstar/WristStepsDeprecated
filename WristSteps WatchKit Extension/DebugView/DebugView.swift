//
//  DebugView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct DebugView: View {
    @EnvironmentObject var provider: DebugViewProvider

    var body: some View {
        VStack {
            headlineValueView(headline: "Background refresh",
                              value: provider.lastBackgroundRefreshString)
            headlineValueView(headline: "Complication trigger",
                              value: provider.lastComplicationTriggerString)
            headlineValueView(headline: "Complication refresh",
                              value: provider.lastComplicationRefreshString)
            Spacer()
        }
    }

    func headlineValueView(headline: String, value: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(headline)
                Spacer()
            }
            HStack {
                Text(value)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                Spacer()
            }
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView().environmentObject(DebugViewProvider())
    }
}
