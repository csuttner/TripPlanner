//
//  EditTripView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

struct EditTripView: View {
    init(trip: Trip) {
        self.trip = trip
        self.changesSaved = !trip.hasChanges
    }

    let trip: Trip

    @Environment(\.modelContext) private var context
    @State private var changesSaved: Bool
    @FocusState private var focusedField: TripField?

    var body: some View {
        List {
            EditTripInfoSection(changesSaved: $changesSaved, focusedField: $focusedField)
            
            EditTripScheduleSection(changesSaved: $changesSaved)
            
            EditTripSaveButton(changesSaved: $changesSaved)
        }
        .environment(trip)
        .contentShape(Rectangle())
        .onTapGesture {
            focusedField = nil
        }
        .navigationTitle(trip.name.isEmpty ? "New Trip" : trip.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    trip.isStarred.toggle()
                    
                } label: {
                    if trip.isStarred {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                    } else {
                        Image(systemName: "star")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    let (trip, container) = Preview.trip
    
    return EditTripView(trip: trip)
        .modelContainer(container)
}
