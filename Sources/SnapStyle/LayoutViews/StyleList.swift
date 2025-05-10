//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleList<SelectionValue: Hashable, Content: View>: View {
    
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
        }
        .scrollContentBackground(.hidden)
        // TODO: Should only apply .screen() and component .list
//        .style(component: .list)
        // Background of screen should ignore .vertical safe area to stretch beyond \.`widthReadableContent`.
        .style(composition: \.screen, ignoreSafeAreaEdges: .vertical)
        .style(component: .list, applyContainer: nil)
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var selection: String? = "Circle"
    
    NavigationStack {
        StyleList(selection: $selection) {
            Section {
                StyleListRow(value: "Circle", isSelected: true) {
                    Label("Circle", systemImage: "circle")
                }
                StyleListRow(value: "Circle", isSelected: false) {
                    Label("Circle", systemImage: "circle")
                }
                Label("Triangle", systemImage: "triangle")
                Label("Rectangle", systemImage: "rectangle")
            } header: {
                Label("Section", systemImage: "star")
                    .style(element: .title)
            }
        }
    }
}
