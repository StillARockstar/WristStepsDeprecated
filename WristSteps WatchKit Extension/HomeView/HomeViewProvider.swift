//
//  HomeViewProvider.swift
//  WristSteps WatchKit Extension
//
//  Created by Michael Schoder on 16.10.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import DataCache

class HomeViewProvider: ObservableObject {
    let dataCache: DataCache

    @Published var steps = 0
    @Published var stepPercent = 0
    @Published var stepGoal = 0

    init(dataCache: DataCache) {
        self.dataCache = dataCache
    }

    func onViewAppear() {
        self.dataCache.addListener(self, for: [.healthData, .userData])
        updateViewData()
    }

    func onViewDisappear() {
        self.dataCache.removeListener(self)
    }

    private func updateViewData() {
        DispatchQueue.main.async {
            let newStepCount = self.dataCache.healthData.stepCount
            let newStepGoal = self.dataCache.userData.stepGoal

            self.steps = newStepCount
            self.stepGoal = newStepGoal

            let calculatedPercent = Double(self.steps) / Double(self.stepGoal)
            self.stepPercent = Int(calculatedPercent * 100)
        }
    }
}

extension HomeViewProvider: DataCacheListener {
    func healthDataChanged(_ dataCache: DataCache) {
        updateViewData()
    }

    func userDataChanged(_ dataCache: DataCache) {
        updateViewData()
    }

    func debugDataChanged(_ dataCache: DataCache) {

    }
}
