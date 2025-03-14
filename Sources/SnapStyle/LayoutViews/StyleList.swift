//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleList<Content: View>: View {
    
    // TODO: Add support for data based inits
    
    private let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        List {
            content()
        }
        .scrollContentBackground(.hidden)
        .style(component: .list)
    }
}


// MARK: - Preview

#Preview {
    StyleList {
        Section {
            Label("Circle", systemImage: "circle")
            Label("Triangle", systemImage: "triangle")
            Label("Rectangle", systemImage: "rectangle")
        } header: {
            Label("Section", systemImage: "star")
                .style(element: .title)
        }
    }
}
