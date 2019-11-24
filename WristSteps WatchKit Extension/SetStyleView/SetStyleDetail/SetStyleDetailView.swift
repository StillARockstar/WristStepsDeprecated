//
//  SetStyleDetailView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 18.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import ClockKit
import DataCache

struct SetStyleDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var provider: SetStyleDetailProvider

    private let buttonHeight: CGFloat = 35.0

    var body: some View {
        VStack {
            HStack {
                stepButton(systemName: "chevron.left") {
                    print("left")
                }
                .padding(.leading, 7.0)

                Spacer()

                Image("preview_templ_gc_1_color_1")
                    .resizable()
                    .frame(width: 60, height: 60)

                Spacer()

                stepButton(systemName: "chevron.right") {
                    print("right")
                }
                .padding(.trailing, 7.0)
            }
            .frame(height: 68)
            Picker(selection: $provider.selectedColorIndex, label: Text("Color")) {
                ForEach(0..<provider.availableColorNames.count) { index in
                    Text(self.provider.availableColorNames[index]).tag(index)
                }
            }
            .frame(height: 40)
            Button(action: {
                self.provider.commitCurrentStyleConfiguration()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Update")
            }
            .cornerRadius(40.0)
        }
        .navigationBarTitle("Back")
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

struct SetStyleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleDetailView().environmentObject(SetStyleDetailProvider(dataCache: SampleDataCache(), clockConnector: ClockConnector(), family: .graphicCircular))
    }
}
