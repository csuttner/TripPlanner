//
//  TripListView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftUI

struct TripListView: View {
    @Environment(\.modelContext) private var context
    
    var results: [Trip]
    
    @Binding var config: HomeConfig
    
    var body: some View {
        List(results, id: \.id, selection: $config.selection) { trip in
            TripListRow(trip: trip, editMode: $config.editMode) {
                config.path.append(trip)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                Button {
                    trip.isStarred.toggle()
                } label: {
                    Image(systemName: trip.isStarred ? "star.slash" : "star.fill")
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
        .listStyle(.plain)
    }
}
