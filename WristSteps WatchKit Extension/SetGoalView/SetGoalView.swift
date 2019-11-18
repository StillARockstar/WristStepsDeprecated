//
//  SetGoalView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 23.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct SetGoalView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var provider: SetGoalProvider
    
    var body: some View {
        VStack {
            Spacer()
            Text("Stepgoal".uppercased())
                .foregroundColor(.appBlue)
                .font(.body)
                .fixedSize()
            SetGoalEditorView().environmentObject(provider)
            Text("The recommended amount of steps is \(10000) per day")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)

            Button(action: {
                self.provider.commitStepGoal()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Update Goal")
            }
            .cornerRadius(40.0)
        }
        .navigationBarTitle("Set Goal")
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView().environmentObject(SetGoalProvider(dataCache: DataCache()))
    }
}
