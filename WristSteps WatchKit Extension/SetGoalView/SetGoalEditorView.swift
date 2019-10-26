//
//  SetGoalEditorView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct SetGoalEditorView: View {
    var currentGoal: Int
    private let buttonHeight: CGFloat = 35.0

    var body: some View {
        HStack {
            stepButton(systemName: "minus") {
                print("--")
            }
            .padding(.leading, 7.0)

            Spacer()

            Text("\(currentGoal.kFormattedString)")
                .foregroundColor(.white)
                .font(.title)

            Spacer()

            stepButton(systemName: "plus") {
                print("++")
            }
            .padding(.trailing, 7.0)
        }
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
        SetGoalEditorView(currentGoal: 10000)
    }
}
