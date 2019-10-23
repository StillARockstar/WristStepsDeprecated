//
//  GoalView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 23.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct GoalView: View {
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

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(stepGoal: 10000)
    }
}

/*

 VStack(spacing: 0) {
     HStack {
         Text("Today".uppercased())
             .foregroundColor(.gray)
             .font(.body)
         Text("\(stepPercent)%")
             .foregroundColor(.blue)
             .fontWeight(.medium)
         Spacer()
     }
     HStack(alignment: .bottom, spacing: 5) {
         Text("\(stepCount)")
             .foregroundColor(.blue)
             .font(.title)
         Text("steps")
             .foregroundColor(.white)
             .fontWeight(.medium)
             .padding(.bottom, 5)
         Spacer()
     }
 }

 */
