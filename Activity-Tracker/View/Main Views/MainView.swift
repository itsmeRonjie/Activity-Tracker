//
//  ContentView.swift
//  Activity-Tracker
//
//  Created by Ronjie Diafante Man-on on 5/7/25.
//

import SwiftUI
import Charts
import SwiftData

struct MainView: View {
    @Query(sort: \Activity.name, order: .forward) var activities: [Activity]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("Activity Tracker")
        }
    }

}

#Preview {
    MainView()
        .modelContainer(for: Activity.self)
}
