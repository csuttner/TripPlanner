//
//  StarToolbarItem.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftUI

struct StarToolbarItem: ToolbarContent {
    @Environment(Trip.self) private var trip
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                trip.isStarred.toggle()
                
            } label: {
                if trip.isStarred {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}
