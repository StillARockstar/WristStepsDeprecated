//
//  HomeViewContent.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct HomeViewContent: View {
    @EnvironmentObject var provider: HomeViewProvider

    var body: some View {
        VStack {
            HomeCurrentStepView(stepPercent: provider.stepPercent,stepCount: provider.steps)
            HomeGoalView(stepGoal: provider.stepGoal)

            Spacer()

            Text("Press firmly for more options")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
        }
    }
}

struct HomeViewContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewContent().environmentObject(HomeViewProvider(dataCache: DataCache()))
    }
}
