//
//  EditTripScheduleSection.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftUI

struct EditTripScheduleSection: View {
    @Environment(Trip.self) private var trip
    @Binding var changesSaved: Bool
    
    var body: some View {
        @Bindable var trip = trip

        Section("Schedule") {
            VStack(spacing: 24) {
                HStack {
                    Text("Start Date")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    DateAdjusterView(date: $trip.startDate)
                        .onChange(of: trip.startDate) {
                            changesSaved = false
                        }
                }
                
                HStack {
                    Text("End Date")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    DateAdjusterView(date: $trip.endDate)
                        .onChange(of: trip.endDate) {
                            changesSaved = false
                        }
                }
            }
        }
    }
}
