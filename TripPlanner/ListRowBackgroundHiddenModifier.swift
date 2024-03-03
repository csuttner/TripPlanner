//
//  ListRowBackgroundHiddenModifier.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/2/24.
//

import SwiftUI

struct ListRowBackgroundHiddenModifier: ViewModifier {
    var hidden: Bool
    
    func body(content: Content) -> some View {
        if hidden {
            content
                .listRowBackground(Color.clear)

        } else {
            content
        }
    }
}

extension View {
    func listRowBackground(hidden: Bool) -> some View {
        modifier(ListRowBackgroundHiddenModifier(hidden: hidden))
    }
}
