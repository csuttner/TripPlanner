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
    case startDate
    case endDate
}

struct TripFormView: View {
    var trip: Trip
    
    @Binding var changesSaved: Bool
    
    @FocusState private var focusedField: TripField?
    
    var body: some View {
        @Bindable var trip = trip

        VStack(alignment: .leading, spacing: 24) {
            formField("Name", observe: $trip.name) {
                TextField("Name", text: $trip.name)
                    .focused($focusedField, equals: .name)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
            }
            
            formField("Destination", observe: $trip.destination) {
                TextField("Destination", text: $trip.destination)
                    .focused($focusedField, equals: .destination)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
            }
            
            formField("Start Date", observe: $trip.startDate) {
                DateAdjusterView(date: $trip.startDate)
            }
            
            formField("End Date", observe: $trip.endDate) {
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
    
    @ViewBuilder private func formField<T: Equatable>(
        _ title: String,
        observe binding: Binding<T>,
        _ content: @escaping (() -> some View)
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(.secondary)
            
            content()
        }
        .onChange(of: binding.wrappedValue) {
            changesSaved = false
        }
    }
}

#Preview {
    let (trip, container) = Preview.trip
    
    return TripFormView(trip: trip, changesSaved: .constant(false))
        .modelContainer(container)
}
