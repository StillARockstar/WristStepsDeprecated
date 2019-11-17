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
                ForEach(0 ..< provider.activeComplicationFamilies.count) {
                    self.row(
                        rowItem: self.provider.activeComplicationFamilies[$0],
                        index: $0)
                }
            }

            Section(header: Text("All Complications")) {
                ForEach(0 ..< provider.allComplicationFamilies.count) {
                    self.row(
                        rowItem: self.provider.allComplicationFamilies[$0],
                        index: self.provider.activeComplicationFamilies.count + $0)
                }
            }
        }
    }

    func row(rowItem: SetStyleListRowItem, index: Int) -> some View {
        SetStyleListRow(rowItem: rowItem)
            .onTapGesture {
                print("Tapped: \(index)")
        }
    }
}

struct SetStyleListView_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleListView().environmentObject(SetStyleProvider(dataCache: DataCache(), clockConnector: ClockConnector()))
    }
}
