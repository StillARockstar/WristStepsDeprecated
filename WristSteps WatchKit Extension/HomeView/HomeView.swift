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

    var body: some View {
        VStack {
            CurrentStepView(stepPercent: provider.stepPercent,stepCount: provider.steps)
            GoalView(stepGoal: provider.stepGoal)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewProvider(connector: HealthConnector.default))
    }
}
