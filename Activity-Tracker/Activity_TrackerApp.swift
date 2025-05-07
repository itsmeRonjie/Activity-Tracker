//
//  Activity_TrackerApp.swift
//  Activity-Tracker
//
//  Created by Ronjie Diafante Man-on on 5/7/25.
//

import SwiftUI
import SwiftData

@main
struct Activity_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Activity.self)
    }
}
