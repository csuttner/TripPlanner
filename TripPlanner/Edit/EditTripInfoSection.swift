//
//  EditTripInfoSection.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftUI

enum TripField: String {
    case name
    case destination
}

struct EditTripInfoSection: View {
    @Environment(Trip.self) private var trip
    @Binding var changesSaved: Bool
    @FocusState.Binding var focusedField: TripField?

    var body: some View {
        @Bindable var trip = trip

        Section("Info") {
            VStack(alignment: .leading) {
                Text("Name")
                    .foregroundStyle(.secondary)

                TextField("Name", text: $trip.name)
                    .focused($focusedField, equals: .name)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
                    .onChange(of: trip.name) {
                        changesSaved = false
                    }
            }
            
            VStack(alignment: .leading) {
                Text("Destination")
                    .foregroundStyle(.secondary)
                
                TextField("Destination", text: $trip.destination)
                    .focused($focusedField, equals: .destination)
                    .textFieldStyle(.roundedBorder)
                    .font(.title2)
                    .onChange(of: trip.destination) {
                        changesSaved = false
                    }
            }
        }
        .listRowSeparator(.hidden)
        .onSubmit {
            switch focusedField {
            case .name:
                focusedField = .destination
                
            default:
                focusedField = nil
            }
        }
    }
}
