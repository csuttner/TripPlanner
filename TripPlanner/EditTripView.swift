//
//  EditTripView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

struct EditTripView: View {
    var trip: Trip
    
    @Environment(\.modelContext) private var context
    
    @State private var error: AppError?
    @State private var areChangesSaved = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                TripFormView(trip: trip)
                
                Spacer()
                
                Button(areChangesSaved ? "Saved" : "Save") {
                    if emptyValues.isEmpty {
                        save()
                    } else {
                        error = .missingValues(emptyValues)
                    }
                }
                .disabled(areChangesSaved)
                .font(.title2)
                .fontWeight(.semibold)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .onChange(of: trip) {
                areChangesSaved = false
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
            areChangesSaved = true
            
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
