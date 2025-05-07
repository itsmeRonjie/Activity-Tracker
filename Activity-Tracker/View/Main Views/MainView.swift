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
    
    @State private var newName: String = ""
    @State private var newHoues: Double = 0
    @State private var currentActivty: Activity? = nil
    @State private var selectCount: Int?
    

    var body: some View {
        NavigationStack {
            VStack {
                Chart {
                    ForEach(activities) { activity in
                        let isSelected: Bool = activity == currentActivty
                        SectorMark(
                            angle: .value("Activities", activity.hoursPerDay),
                            innerRadius: .ratio(0.6),
                            outerRadius: .ratio(
                                isSelected ? 1.05 : 0.95
                            ),
                            angularInset: 1
                        )
                        .foregroundStyle(.red)
                    }
                }
            }
            .padding()
            .navigationTitle("Activity Tracker")
        }
    }

}

#Preview {
    MainView()
        .modelContainer(for: Activity.self)
}
