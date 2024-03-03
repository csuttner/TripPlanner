//
//  TripFormView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

enum TripField: String {
    case name
    case destination
}

struct TripFormView: View {
    var trip: Trip
    
    @FocusState private var focusedField: TripField?
    
    var body: some View {
        @Bindable var trip = trip

        VStack(alignment: .leading, spacing: 24) {
            formField("Name") {
                TextField("Name", text: $trip.name)
                    .focused($focusedField, equals: .name)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
            }
            
            formField("Destination") {
                TextField("Destination", text: $trip.destination)
                    .focused($focusedField, equals: .destination)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
            }
            
            formField("Start Date") {
                DateAdjusterView(date: $trip.startDate)
            }
            
            formField("End Date") {
                DateAdjusterView(date: $trip.endDate)
            }
        }
        .onSubmit {
            switch focusedField {
            case .name:
                focusedField = .destination
                
            default:
                focusedField = nil
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            focusedField = nil
        }
    }
    
    @ViewBuilder private func formField(
        _ title: String,
        _ content: @escaping (() -> some View)
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(.secondary)
            
            content()
        }
    }
}

#Preview {
    let (trip, container) = Preview.trip
    
    return TripFormView(trip: trip)
        .modelContainer(container)
}
