//
//  SetStyleListRow.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import SwiftUI

struct SetStyleListRow: View {
    let rowItem: SetStyleListRowItem

    var body: some View {
        HStack {
            rowItem.thumbImage
            Text(rowItem.title)
            Spacer()
        }
    }
}

struct SetStyleListRow_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleListRow(rowItem: SetStyleListRowItem(family: .graphicCircular, thumbImage: Image("radialGraph0"), title: "Graphic Circular"))
            .previewLayout(.fixed(width: 150, height: 45))
    }
}
