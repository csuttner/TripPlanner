//
//  DateAdjusterView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct DateAdjusterView: View {
    @Binding var date: Date

    var body: some View {
        HStack {
            Text(date.abbreviated)
                .font(.title2)
            
            Spacer()
            
            HStack(alignment: .center) {
                Button("", systemImage: "minus.circle") {
                    changeDate(by: -1)
                }
                .buttonRepeatBehavior(.enabled)

                Button("", systemImage: "plus.circle") {
                    changeDate(by: 1)
                }
                .buttonRepeatBehavior(.enabled)
            }
            .font(.title2)
            .fontWeight(.bold)
        }
    }
    
    private func changeDate(by value: Int) {
        date = Calendar.current.date(
            byAdding: .day,
            value: value,
            to: date
        ) ?? date
    }
}

#Preview {
    DateAdjusterView(date: .constant(Date()))
}
