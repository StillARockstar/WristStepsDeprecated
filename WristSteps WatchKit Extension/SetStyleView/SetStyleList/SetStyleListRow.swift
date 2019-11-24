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
            HStack {
                Spacer()
                rowItem.thumbImage
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5.0)
                    .padding([.top, .bottom], 5.0)
                Spacer()
            }
        }
    }
}

struct SetStyleListRow_Previews: PreviewProvider {
    static var previews: some View {
        SetStyleListRow(rowItem: SetStyleListRowItem(family: .graphicCircular, thumbImage: Image("preview_templ_gc_1_color_1")))
            .previewLayout(.fixed(width: 150, height: 50))
    }
}
