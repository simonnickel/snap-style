//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


import SwiftUI

public struct StyleListRow<SelectionValue: Hashable, Content: View>: View {
    
    private let value: SelectionValue?
    private let isSelected: Bool
    private let content: () -> Content
    
    public init(value: SelectionValue?, isSelected: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.value = value
        self.isSelected = isSelected
        self.content = content
    }
    
    public init(isSelected: Bool = false, @ViewBuilder content: @escaping () -> Content) where SelectionValue == Never {
        self.value = nil
        self.isSelected = isSelected
        self.content = content
    }
    
    public var body: some View {
        Group {
            if let value {
                NavigationLink(value: value) {
                    content()
                }
            } else {
                content()
            }
        }
        .style(listRowBackground: \.interactiveListRow)
        // TODO: Highlight on hover and navigation selection. Only use selected for actual selection.
        .style(component: .listRow, applyContainer: nil, state: isSelected ? .selected : .normal)
    }
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        List {
            StyleListRow(value: "Circle", isSelected: true) {
                Label("Circle", systemImage: "circle")
            }
            StyleListRow(value: "Circle", isSelected: false) {
                Label("Circle", systemImage: "circle")
            }
            Label("Triangle", systemImage: "triangle")
            Label("Rectangle", systemImage: "rectangle")
        }
    }

}
