//
//  HomeView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    @State private var selection = Set<String>()
    @State private var editMode = EditMode.inactive
    @State private var path = [Trip]()
    
    @Query var trips: [Trip]
    
    var body: some View {
        NavigationStack(path: $path) {
            TripListView(
                trips: trips,
                selection: $selection,
                path: $path,
                editMode: $editMode
            )
            .listStyle(.plain)
            .navigationDestination(for: Trip.self) { trip in
                EditTripView(trip: trip)
            }
            .navigationTitle("Trips")
            .toolbar {
                if !trips.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                
                NewTripToolbarItem(path: $path)
                
                if !selection.isEmpty {
                    DeleteTripToolbarItem(trips: trips, selection: $selection)
                }
            }
            .environment(\.editMode, $editMode)
            .onChange(of: trips) {
                if trips.isEmpty {
                    editMode = .inactive
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Trip.self)
}
