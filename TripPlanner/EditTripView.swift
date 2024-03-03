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
    
    var trip: Trip
    
    @Environment(\.modelContext) private var context
    
    @State private var error: AppError?
    @State private var changesSaved: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                TripFormView(trip: trip, changesSaved: $changesSaved)

                Spacer()
                
                Button(changesSaved ? "Saved" : "Save") {
                    if emptyValues.isEmpty {
                        save()
                    } else {
                        error = .missingValues(emptyValues)
                    }
                }
                .disabled(changesSaved)
                .font(.title2)
                .fontWeight(.semibold)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .alert("Error", isPresented: $error.isSome) {
                Text("Ok")
            } message: {
                Text(error?.localizedDescription ?? "")
            }
            .navigationTitle(trip.name.isEmpty ? "New Trip" : trip.name)
            .padding()
        }
    }
    
    private var emptyValues: [String] {
        let fields: [TripField?] = [
            trip.name.isEmpty ? .name : nil,
            trip.destination.isEmpty ? .destination : nil
        ]
        
        return fields.compactMap { $0?.rawValue }
    }
    
    private func save() {
        do {
            context.insert(trip)
            try context.save()
            changesSaved = true
            
        } catch {
            self.error = .save(error)
        }
    }
}

#Preview {
    let (trip, container) = Preview.trip
    
    return EditTripView(trip: trip)
        .modelContainer(container)
}
