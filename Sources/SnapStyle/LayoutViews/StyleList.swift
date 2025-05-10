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
        StyleScreen(component: .list, configuration: [.readableContentWidthFixed]) {
            List {
                content()
            }
            .scrollContentBackground(.hidden)
        }
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
