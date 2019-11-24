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
    @EnvironmentObject var provider: SetStyleListProvider

    var body: some View {
        List {
            Section(header: Text("Active Complications")) {
                ForEach(0 ..< provider.activeComplicationFamilies.count) {
                    self.row(rowItem: self.provider.activeComplicationFamilies[$0])
                }
            }

            Section(header: Text("All Complications")) {
                ForEach(0 ..< provider.allComplicationFamilies.count) {
                    self.row(rowItem: self.provider.allComplicationFamilies[$0])
                }
            }
        }
        .navigationBarTitle("Set Style")
    }

    func row(rowItem: SetStyleListRowItem) -> some View {
        NavigationLink(destination: detailView(family: rowItem.family)) {
            SetStyleListRow(rowItem: rowItem)
        }
    }

    func detailView(family: CLKComplicationFamily) -> some View {
        return SetStyleDetailView()
            .environmentObject(SetStyleDetailProvider(
                dataCache: provider.dataCache,
                clockConnector: provider.clockConnector,
                family: family))
    }
}

struct SetStyleListView_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleListView().environmentObject(SetStyleListProvider(dataCache: SampleDataCache(), clockConnector: ClockConnector()))
    }
}
