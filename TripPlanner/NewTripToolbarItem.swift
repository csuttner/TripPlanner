//
//  NewTripToolbarItem.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct NewTripToolbarItem: ToolbarContent {
    @Environment(\.modelContext) private var context
    
    @Binding var path: [Trip]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                let newTrip = Trip()
                context.insert(newTrip)
                path.append(newTrip)

            } label: {
                HStack {
                    Text("New")
                    
                    Image(systemName: "airplane")
                        .fontWeight(.ultraLight)
                }
            }
        }
    }
}
