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

    var body: some View {
        VStack {
            Picker(selection: $provider.selectedStyle, label: Text("Style")) {
                ForEach(0..<provider.availableStyles.count) { index in
                    self.provider.availableStyles[index].tag(index)
                }
            }
            .frame(height: 68)
            Picker(selection: $provider.selectedColor, label: Text("Color")) {
                ForEach(0..<provider.availableColors.count) { index in
                    Text(self.provider.availableColors[index]).tag(index)
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
}

struct SetStyleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleDetailView().environmentObject(SetStyleDetailProvider(dataCache: DataCache(), family: .graphicCircular))
    }
}
