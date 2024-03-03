//
//  Preview+Trip.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

extension Preview {
    static let trip: (Trip, ModelContainer) = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RowItem.self, configurations: config)
        
        return (Trip(), container)
    }()
    
}
