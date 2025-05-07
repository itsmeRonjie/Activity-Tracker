//
//  ActivityRow.swift
//  Activity-Tracker
//
//  Created by Ronjie Diafante Man-on on 5/7/25.
//

import SwiftUI

struct ActivityRow: View {
    let activity: Activity
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.name)
                    .font(.headline)
                Text("Hours per day: \(activity.hoursPerDay.formatted())")
            }
            Spacer()
        }
    }
}

#Preview {
    ActivityRow(
        activity: Activity(
            name: "Coding",
            hoursPerDay: 8
        )
    )
    .padding()
}
