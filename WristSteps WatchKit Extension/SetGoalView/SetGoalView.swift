//
//  SetGoalView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 23.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct SetGoalView: View {
    @EnvironmentObject var provider: SetGoalProvider
    
    var body: some View {
        VStack(spacing: 5.0) {
            Text("\(provider.stepGoal.kFormattedString)")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView().environmentObject(SetGoalProvider())
    }
}
