//
//  SetGoalEditorView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct SetGoalEditorView: View {
    @EnvironmentObject var provider: SetGoalProvider
    private let buttonHeight: CGFloat = 35.0

    var body: some View {
        HStack {
            stepButton(systemName: "minus") {
                self.provider.stepGoal -= 100
            }
            .padding(.leading, 7.0)

            Spacer()

            Text("\(Int(provider.stepGoal).kFormattedString)")
                .foregroundColor(.white)
                .font(.title)

            Spacer()

            stepButton(systemName: "plus") {
                self.provider.stepGoal += 100
            }
            .padding(.trailing, 7.0)
        }
        .focusable(true)
        .digitalCrownRotation($provider.stepGoal, from: 1000, through: 90000, by: 100, sensitivity: .high)
    }

    func stepButton(systemName: String, action: @escaping (() -> Void)) -> some View {
        Button(action: {
            action()
        }) {
            Image(systemName: systemName)
                .font(.headline)
                .foregroundColor(.black)
        }
        .background(Color.appBlue)
        .frame(width: buttonHeight, height: buttonHeight, alignment: .center)
        .cornerRadius(buttonHeight / 2.0)
    }
}

struct SetGoalEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalEditorView().environmentObject(SetGoalProvider(dataCache: DataCache(), initialGoal: 10000))
    }
}
