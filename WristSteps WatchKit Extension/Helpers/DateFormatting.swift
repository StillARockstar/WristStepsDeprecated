//
//  DateFormatting.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 26.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation

extension Date {
    func formattedString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
