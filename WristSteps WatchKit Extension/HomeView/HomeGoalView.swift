//
//  HomeGoalView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 23.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct HomeGoalView: View {
    let stepGoal: Int

    var body: some View {
        HStack {
            Text("Goal".uppercased())
                .foregroundColor(.gray)
                .font(.body)
            Text("\(stepGoal) steps")
                .foregroundColor(.white)
                .fontWeight(.medium)
            Spacer()
        }
    }
}

struct HomeGoalView_Previews: PreviewProvider {
    static var previews: some View {
        HomeGoalView(stepGoal: 10000)
    }
}
