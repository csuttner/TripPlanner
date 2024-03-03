//
//  DynamicStack.swift
//  TripPlanner
//
//  Created by Clay Suttner on 3/3/24.
//

import SwiftUI

struct DynamicStack<Content>: View where Content: View {
    let axis: Axis
    let alignment: Alignment
    let spacing: CGFloat?
    let content: () -> Content
    
    init(
        _ axis: Axis,
        alignment: Alignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        switch axis {
        case .horizontal:
            HStack(
                alignment: verticalAlignment,
                spacing: spacing,
                content: content
            )

        case .vertical:
            VStack(
                alignment: horizontalAlignment,
                spacing: spacing,
                content: content
            )
        }
    }
    
    private var verticalAlignment: VerticalAlignment {
        switch alignment {
        case .top:
            return .top

        case .bottom:
            return .bottom

        default:
            return .center
        }
    }
    
    private var horizontalAlignment: HorizontalAlignment {
        switch alignment {
        case .leading:
            return .leading

        case .trailing:
            return .trailing

        default:
            return .center
        }
    }
}
