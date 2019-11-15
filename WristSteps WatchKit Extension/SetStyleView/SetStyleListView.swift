//
//  SetStyleView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct SetStyleListView: View {
    @EnvironmentObject var provider: SetStyleProvider

    var body: some View {
        List {
            Section(header: Text("Active Complications")) {
                ForEach(provider.activeComplicationFamilies, id: \.title) { rowItem in
                    SetStyleListRow(rowItem: rowItem)
                }
            }

            Section(header: Text("All Complications")) {
                ForEach(provider.allComplicationFamilies, id: \.title) { rowItem in
                    SetStyleListRow(rowItem: rowItem)
                }
            }
        }
    }
}

struct SetStyleListView_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleListView().environmentObject(SetStyleProvider(dataCache: DataCache()))
    }
}
