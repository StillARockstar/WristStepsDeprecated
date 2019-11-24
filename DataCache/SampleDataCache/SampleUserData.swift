//
//  SampleUserData.swift
//  DataCache
//
//  Created by Michael Schoder on 24.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

class SampleUserData: UserData {
    var stepGoal: Int {
        get { return 10000 }
        set { }
    }

    func setSelectedTemplateStyleId(for family: CLKComplicationFamily, templateStyleId: String) { }
    func getSelectedTemplateStyleId(for family: CLKComplicationFamily) -> String? { return nil }
    func setSelectedColorStyleId(for family: CLKComplicationFamily, colorStyleId: String) { }
    func getSelectedColorStyleId(for family: CLKComplicationFamily) -> String? { return nil }
}
