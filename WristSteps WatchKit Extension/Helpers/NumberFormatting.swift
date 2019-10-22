//
//  Int+Extensions.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 22.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

extension Int {
    var formattedString: String {
        return NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
}
