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
    @State var showingSetGoal = false
    @State var showingDebug = false

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
            Button(action: {
                self.showingSetGoal.toggle()
            }) {
                VStack {
                    Image(systemName: "flag")
                        .font(.title)
                    Text("Set Goal")
                }
            }
            .sheet(isPresented: $showingSetGoal) {
                SetGoalView()
                    .environmentObject(SetGoalProvider(dataCache: self.provider.dataCache))
            }
            #if DEBUG
            Button(action: {
                self.showingDebug.toggle()
            }) {
                VStack{
                    Image(systemName: "info")
                        .font(.title)
                    Text("Debug")
                }
            }
            .sheet(isPresented: $showingDebug) {
                DebugView()
                    .environmentObject(DebugViewProvider(dataCache: self.provider.dataCache))
            }
            #endif
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewProvider(dataCache: DataCache()))
    }
}
