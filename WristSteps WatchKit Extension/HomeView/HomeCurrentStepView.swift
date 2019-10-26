//
//  CurrentStepView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct HomeCurrentStepView: View {
    let stepPercent: Int
    let stepCount: Int

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Today".uppercased())
                    .foregroundColor(.gray)
                    .font(.body)
                Text("\(stepPercent)%")
                    .foregroundColor(.appBlue)
                    .fontWeight(.medium)
                Spacer()
            }
            HStack(alignment: .bottom, spacing: 5) {
                Text("\(stepCount)")
                    .foregroundColor(.appBlue)
                    .font(.title)
                Text("steps")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .padding(.bottom, 5)
                Spacer()
            }
        }
    }
}

struct HomeCurrentStepView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCurrentStepView(stepPercent: 10, stepCount: 1000)
    }
}
