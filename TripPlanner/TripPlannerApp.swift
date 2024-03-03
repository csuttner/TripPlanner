//
//  TripPlannerApp.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI
import SwiftData

@main
struct TripPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: Trip.self, isAutosaveEnabled: false)
                .symbolRenderingMode(.multicolor)
        }
    }
}
