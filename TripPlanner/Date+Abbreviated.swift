//
//  Date+Abbreviated.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import Foundation

extension Date {
    var abbreviated: String {
        formatted(date: .abbreviated, time: .omitted)
    }
}
