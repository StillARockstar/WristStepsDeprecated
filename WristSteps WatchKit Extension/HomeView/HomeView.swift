//
//  ContentView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var provider: HomeViewProvider
    @State var showingSetGoal = false
    @State var showingDebug = false

    var body: some View {
        VStack {
            HomeCurrentStepView(stepPercent: provider.stepPercent,stepCount: provider.steps)
            HomeGoalView(stepGoal: provider.stepGoal)

            Spacer()

            Button(action: {
                self.showingSetGoal.toggle()
            }) {
                Text("Change Goal")
            }
            .sheet(isPresented: $showingSetGoal) {
                SetGoalView().environmentObject(SetGoalProvider(initialGoal: self.provider.stepGoal))
            }
        }
        .contextMenu {
            contextMenuContent
        }
    }

    private var contextMenuContent: some View {
        Group {
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
                DebugView().environmentObject(DebugViewProvider())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewProvider())
    }
}
