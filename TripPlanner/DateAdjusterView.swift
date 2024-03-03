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
        HStack(alignment: .center) {
            Button {
                changeDate(by: -1)
            } label: {
                Image(systemName: "chevron.left")
            }
            .buttonStyle(.borderless)
            .buttonRepeatBehavior(.enabled)
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .frame(width: 136)

            Button {
                changeDate(by: 1)
            } label: {
                Image(systemName: "chevron.right")
            }
            .buttonStyle(.borderless)
            .buttonRepeatBehavior(.enabled)
        }
        .font(.title2)
        .fontWeight(.bold)
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
    return DateAdjusterView(date: .constant(Date()))
}
