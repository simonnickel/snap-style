//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleList<SelectionValue: Hashable, Content: View>: View {
    
    // TODO: Add support for data based inits
    
    private let selection: Binding<SelectionValue?>?
    private let content: () -> Content
    
    public init(selection: Binding<SelectionValue?>?, @ViewBuilder content: @escaping () -> Content) {
        self.selection = selection
        self.content = content
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) where SelectionValue == Never {
        self.selection = nil
        self.content = content
    }
    
    public var body: some View {
        List {
            content()
                .style(listRowBackground: \.containerList)
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
