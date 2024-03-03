//
//  DeleteTripToolbarItem.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct DeleteTripToolbarItem: ToolbarContent {
    @Environment(\.modelContext) private var context
    
    var trips: [Trip]
    
    @Binding var selection: Set<String>

    var body: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button("Delete ^[\(selection.count) item](inflect: true)") {
                for id in selection {
                    if let trip = trips.first(where: { $0.id == id }) {
                        context.delete(trip)
                        selection.remove(id)
                    }
                }
            }
        }
    }
}
