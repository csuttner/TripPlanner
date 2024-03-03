//
//  EditTripSaveButton.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftUI

struct EditTripSaveButton: View {
    @Environment(\.modelContext) private var context
    @Environment(Trip.self) private var trip
    @Binding var changesSaved: Bool
    @State private var error: AppError?
    
    var body: some View {
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
        .alert("Error", isPresented: $error.isSome) {
            Button("Ok") {
                error = nil
            }
        } message: {
            Text(error?.localizedDescription ?? "")
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
