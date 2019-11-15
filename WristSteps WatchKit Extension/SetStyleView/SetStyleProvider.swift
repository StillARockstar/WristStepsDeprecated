//
//  SetStyleProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 15.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import DataCache

class SetStyleProvider: ObservableObject {
    let dataCache: DataCache

    init(dataCache: DataCache) {
        self.dataCache = dataCache
    }
}
