//
//  HomeContentView.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct HomeContentView: View {
    @Environment(\.modelContext) private var context
    
    var trips: [Trip]
    
    @Binding var config: HomeConfig
    
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
                .symbolRenderingMode(.multicolor)
                
            } else {
                VStack {
                    if results.isEmpty {
                        ContentUnavailableView(
                            "No search results for \(query)",
                            systemImage: "text.magnifyingglass"
                        )
                        .symbolRenderingMode(.multicolor)

                    } else {
                        TripListView(results: results, config: $config)
                    }
                }
                .searchable(text: $query)
            }
        }
        
    }
}
