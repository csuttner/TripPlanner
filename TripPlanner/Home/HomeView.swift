//
//  HomeView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

struct HomeConfig {
    var selection = Set<String>()
    var editMode = EditMode.inactive
    var path = [Trip]()
}

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    @State private var config = HomeConfig()
    
    @Query var trips: [Trip]
    
    var body: some View {
        NavigationStack(path: $config.path) {
            HomeContentView(trips: trips, config: $config)
                .navigationDestination(for: Trip.self) { trip in
                    TripDetailView(trip: trip)
                }
                .navigationTitle("Trips")
                .toolbar {
                    if !trips.isEmpty {
                        ToolbarItem(placement: .topBarLeading) {
                            EditButton()
                        }
                    }
                    
                    NewTripToolbarItem(path: $config.path)
                    
                    if !config.selection.isEmpty {
                        DeleteTripToolbarItem(trips: trips, selection: $config.selection)
                    }
                }
                .environment(\.editMode, $config.editMode)
                .onChange(of: trips) {
                    if trips.isEmpty {
                        config.editMode = .inactive
                    }
                }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Trip.self)
}
