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

    var body: some View {
        VStack {
            HomeCurrentStepView(stepPercent: provider.stepPercent,stepCount: provider.steps)
            HomeGoalView(stepGoal: provider.stepGoal)
            Spacer()
        }
        .contextMenu {
            contextMenuContent
        }
        .sheet(isPresented: $showingSetGoal) {
            SetGoalView()
        }
    }

    private var contextMenuContent: some View {
        Button(action: {
            self.showingSetGoal.toggle()
        }) {
            VStack{
                Image(systemName: "arrow.up.and.down")
                    .font(.title)
                Text("Change Goal")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewProvider(connector: HealthConnector.default))
    }
}
