//
//  SetStyleView.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI
import DataCache

struct SetStyleView: View {
    @EnvironmentObject var provider: SetStyleProvider

    var body: some View {
        Text("Style View")
    }
}

struct SetStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleView().environmentObject(SetStyleProvider(dataCache: DataCache()))
    }
}
