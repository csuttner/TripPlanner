//
//  NewTripToolbarItem.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct NewTripToolbarItem: ToolbarContent {
    @Binding var path: [Trip]
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                path.append(Trip())

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
