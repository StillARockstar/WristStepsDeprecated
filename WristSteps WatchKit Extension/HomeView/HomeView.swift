//
//  ContentView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct HomeView: View {
    @EnvironmentObject var provider: HomeViewProvider

    var body: some View {
        HomeViewContent()
        .environmentObject(provider)
        .navigationBarTitle("WristSteps")
        .onAppear() {
            self.provider.onViewAppear()
        }
        .onDisappear() {
            self.provider.onViewDisappear()
        }
        .contextMenu {
            contextMenuContent
        }
    }

    private var contextMenuContent: some View {
        Group {
            NavigationLink(destination: setGoalView) {
                VStack {
                    Image(systemName: "flag")
                        .font(.title)
                    Text("Goal")
                }
            }
            NavigationLink(destination: setStyleView) {
                VStack {
                    Image(systemName: "paintbrush")
                        .font(.title)
                    Text("Style")
                }
            }
            #if DEBUG
            NavigationLink(destination: debugView) {
                VStack{
                    Image(systemName: "info")
                        .font(.title)
                    Text("Debug")
                }
            }
            #endif
        }
    }

    var setGoalView: some View {
        SetGoalView()
            .environmentObject(SetGoalProvider(
                dataCache: self.provider.dataCache))
    }

    var setStyleView: some View {
        SetStyleListView()
            .environmentObject(SetStyleListProvider(
                dataCache: self.provider.dataCache,
                clockConnector: self.provider.clockConnector))
    }

    var debugView: some View {
        DebugView()
            .environmentObject(DebugViewProvider(
                dataCache: self.provider.dataCache))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewProvider(dataCache: DataCache(), clockConnector: ClockConnector()))
    }
}
