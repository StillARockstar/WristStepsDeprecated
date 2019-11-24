//
//  UserData.swift
//  DataCache
//
//  Created by Michael Schoder on 06.11.19.
//  Copyright © 2019 Michael Schoder. All rights reserved.
//

import Foundation
import ClockKit

public class AppUserData: DataEntity, UserData {
    private let dataStore: DataStore
    private let defaultStepGoal = 10000

    var onDataChanged: (() -> Void)?
    
    required init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    public var stepGoal: Int {
        get {
            return dataStore.read(key: .stepGoal) as? Int ?? defaultStepGoal
        }
        set {
            dataStore.write(value: newValue, key: .stepGoal)
            onDataChanged?()
        }
    }

    public func setSelectedTemplateStyleId(for family: CLKComplicationFamily, templateStyleId: String) {
        guard let familyId = family.dataCacheId else { return }
        let key = "\(familyId)_templ"
        dataStore.write(value: templateStyleId, key: key)
    }

    public func getSelectedTemplateStyleId(for family: CLKComplicationFamily) -> String? {
        guard let familyId = family.dataCacheId else { return nil }
        let key = "\(familyId)_templ"
        return dataStore.read(key: key) as? String
    }

    public func setSelectedColorStyleId(for family: CLKComplicationFamily, colorStyleId: String) {
        guard let familyId = family.dataCacheId else { return }
        let key = "\(familyId)_color"
        dataStore.write(value: colorStyleId, key: key)
    }

    public func getSelectedColorStyleId(for family: CLKComplicationFamily) -> String? {
        guard let familyId = family.dataCacheId else { return nil }
        let key = "\(familyId)_color"
        return dataStore.read(key: key) as? String
    }
}
