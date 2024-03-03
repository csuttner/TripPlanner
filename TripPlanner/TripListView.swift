//
//  TripListView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct TripListView: View {
    @Environment(\.modelContext) private var context
    
    var trips: [Trip]
    
    @Binding var selection: Set<String>
    @Binding var path: [Trip]
    @Binding var editMode: EditMode
    
    @State private var query = ""
    
    private var results: [Trip] {
        query.isEmpty ? trips : trips.filter {
            $0.name.contains(query) ||
            $0.destination.contains(query)
        }
    }
    
    var body: some View {
        VStack {
            if trips.isEmpty {
                ContentUnavailableView(
                    "Add a trip to get started",
                    systemImage: "sparkles"
                )
                
            } else if results.isEmpty {
                ContentUnavailableView(
                    "No search results for \(query)",
                    systemImage: "text.magnifyingglass"
                )
                
            } else {
                List(results, id: \.id, selection: $selection) { trip in
                    TripListRow(trip: trip, editMode: $editMode) {
                        path.append(trip)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            trip.isStarred.toggle()
                        } label: {
                            if trip.isStarred {
                                Label("Starred", systemImage: "star.slash")
                            } else {
                                Label("Not Starred", systemImage: "star.fill")
                            }
                        }
                        .tint(trip.isStarred ? .gray : .yellow)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            context.delete(trip)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .searchable(text: $query)
    }
}
