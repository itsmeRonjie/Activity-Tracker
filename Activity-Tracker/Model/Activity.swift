//
//  Activity.swift
//  Activity-Tracker
//
//  Created by Ronjie Diafante Man-on on 5/7/25.
//

import Foundation
import SwiftData

@Model
class Activity {
    @Attribute(.unique) var id: String = UUID().uuidString
    
    var name: String
    var hoursPerDay: Double
    
    init(name: String, hoursPerDay: Double = 0) {
        self.name = name
        self.hoursPerDay = hoursPerDay
    }
}
