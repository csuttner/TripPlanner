//
//  TripListRow.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct TripListRow: View {
    let trip: Trip

    @Binding var editMode: EditMode
    
    let action: (() -> Void)

    var body: some View {
        Button {
            action()

        } label: {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        if trip.isStarred {
                            Image(systemName: "star.fill")
                                .tint(.yellow)
                        }
                        
                        Text(trip.name)
                            .font(.title3)
                    }
                    
                    Text("Starts \(trip.startDate.abbreviated)")
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // manually replicating navigationlink appearance
                // navigationlinks currently dont work inside a selectable list
                if editMode == .inactive {
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(.tertiary)
                }
            }
        }
        .listRowBackground(hidden: editMode == .inactive)
    }
}

#Preview {
    let (trip, container) = Preview.trip
    
    return TripListRow(trip: trip, editMode: .constant(.active), action: {})
        .modelContainer(container)
}
