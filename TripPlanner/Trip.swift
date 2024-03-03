//
//  Trip.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import Foundation
import SwiftData

@Model class Trip {
    // required for multi selection
    let id = UUID().uuidString
    var name: String
    var destination: String
    var startDate: Date
    var endDate: Date
    var accommodation: Accommodation?
    var isStarred: Bool
    
    @Transient var destinationWeather = Weather.current()
    
    init(
        name: String = "",
        destination: String = "",
        startDate: Date = Date(),
        endDate: Date = Date(),
        accommodation: Accommodation? = nil,
        isStarred: Bool = false
    ) {
        self.name = name
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.accommodation = accommodation
        self.isStarred = isStarred
    }
}

struct Accommodation: Codable {
    let name: String
}

struct Weather: Codable {
    let condition: String
    
    static func current() -> Weather {
        Weather(condition: "sunny")
    }
}
