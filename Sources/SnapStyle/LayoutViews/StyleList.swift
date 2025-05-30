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
        StyleScreen(component: .list, configuration: .list) {
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
                StyleListRow(.navigate("Star"), isSelected: true) {
                    StyleLabel("Star", systemImage: "star")
                }
                StyleListRow(.navigate("Circle"), isSelected: false) {
                    StyleLabel("Circle", systemImage: "circle")
                }
                StyleLabel("Triangle", systemImage: "triangle")
                StyleLabel("Rectangle", systemImage: "rectangle")
            } header: {
                StyleLabel("Section", systemImage: "star")
                    .styleListSectionHeaderLabel()
            }
        }
    }
}
