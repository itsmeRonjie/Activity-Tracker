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
    @State private var newHours: Double = 0
    @State private var currentActivty: Activity? = nil
    @State private var hoursPerDay: Double = 0
    @State private var selectCount: Int?
    
    var totalHours: Double {
        var hours = 0.0
        for activity in activities {
            hours += activity.hoursPerDay
        }
        
        return hours
    }
    
    var remainingHours: Double {
        24 - totalHours
    }
    
    var maxHoursSelected: Double {
        remainingHours + hoursPerDay
    }
    
    let step: Double = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                if activities.isEmpty {
                    ContentUnavailableView(
                        "Enter an Activity",
                        systemImage: "list.dash"
                    )
                } else {
                    Chart {
                        ForEach(activities) { activity in
                            let isSelected: Bool = activity == currentActivty
                            SectorMark(
                                angle: .value("Activities", activity.hoursPerDay),
                                innerRadius: .ratio(0.6),
                                outerRadius: .ratio(isSelected ? 1.05 : 0.95),
                                angularInset: 1
                            )
                            .foregroundStyle(.red)
                        }
                    }
                    .chartAngleSelection(value: $selectCount)
                }
                
                List {
                    ForEach(activities) { activity in
                        ActivityRow(activity: activity)
                            .containerShape(Rectangle())
                            .listRowBackground(
                                currentActivty?.name == activity.name ? Color.blue
                                    .opacity(0.3) : Color.clear
                            )
                            .onTapGesture {
                                withAnimation {
                                    currentActivty = activity
                                    hoursPerDay = activity.hoursPerDay
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                
                TextField(
                    "Enter new activity name",
                    text: $newName
                )
                .padding()
                .background(.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray, radius: 2, x: 0, y:2)
                
                if let currentActivty {
                    Slider(
                        value: $hoursPerDay,
                        in: 0...maxHoursSelected,
                        step: step
                    )
                    .onChange(of: hoursPerDay) {
 oldValue,
                        newValue in
                        if let index = self.activities.firstIndex(
                            where: {$0.name == currentActivty
                                .name}) {
                            activities[index].hoursPerDay = newValue
                        }
                    }
                }
                
                Button {
                    add()
                } label: {
                    Text("Add")
                }
                .buttonStyle(.borderedProminent)
                .disabled(remainingHours <= 0)

            }
            .padding()
            .navigationTitle("Activity Tracker")
            .toolbar {
                EditButton()
                    .onChange(of: selectCount) { oldValue, newValue in
                        if let newValue {
                            withAnimation {
                                getSelected(value: newValue)
                            }
                        }
                    }
            }
        }
    }
    
    private func add() {
        if newName.count > 2 && !activities
            .contains(where: { $0.name.lowercased() == newName.lowercased() }) {
            let activity = Activity(
                name: newName,
                hoursPerDay: hoursPerDay
            )
            
            context.insert(activity)
            newName = ""
            
            currentActivty =  activity
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let activity = activities[index]
            context.delete(activity)
        }
    }
    
    private func getSelected(value: Int) {
        
    }
    
}

#Preview {
    MainView()
        .modelContainer(for: Activity.self)
}
