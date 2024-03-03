//
//  AppError.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

enum AppError: LocalizedError {
    case missingValues([String])
    case save(Error)
    
    var errorDescription: String? {
        switch self {
        case let .missingValues(values):
            "Missing values for \(values.joined(separator: ", "))"
        case let .save(error):
            "unable to save - \(error.localizedDescription)"
        }
    }
}

extension Binding where Value == AppError? {
    var isSome: Binding<Bool> {
        Binding<Bool>(
            get: { wrappedValue != nil },
            set: { if !$0 { wrappedValue = nil } }
        )
    }
}
