//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


import SwiftUI

public struct StyleListRow<SelectionValue: Hashable, Content: View>: View {
    
    public enum Mode {
        case plain
        case navigate(_ value: SelectionValue)
        case selected(Bool)
    }
    
    private let mode: Mode
    private let isSelected: Bool
    private let content: () -> Content
    
    public init(_ mode: Mode = .plain, isSelected: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.mode = mode
        self.isSelected = isSelected
        self.content = content
    }
    /// An alternative init is required for mode not specifying a `SelectionValue`.
    public init(_ mode: Mode = .plain, isSelected: Bool = false, @ViewBuilder content: @escaping () -> Content) where SelectionValue == Never {
        self.mode = mode
        self.isSelected = isSelected
        self.content = content
    }
    
    public var body: some View {
        // TODO: Customize Label to use \.spacingElements
        Group {
            switch mode {
                case .plain:
                    content()
                    
                case .navigate(value: let value):
                    NavigationLink(value: value) {
                        content()
                    }
                    
                case .selected(let isSelected):
                    StyleHStack(spacing: \.spacingElements) {
                        content()
                        Spacer()
                        // TODO: Apply font and color
                        StyleIcon(isSelected ? \.selectionOn : \.selectionOff)
                    }
            }
        }
        // .listRowInsets(.zero) // TODO: Configure ListRow inset.
        .style(listRowBackground: \.interactiveListRow)
        // TODO: Highlight on hover and navigation selection. Only use selected for actual selection.
        .style(component: .listRow, applyContainer: nil, state: isSelected ? .selected : .normal)
    }
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        List {
            StyleListRow(.navigate("Star"), isSelected: true) {
                Label("Star", systemImage: "star")
            }
            StyleListRow(.navigate("Circle"), isSelected: false) {
                Label("Circle", systemImage: "circle")
            }
            StyleListRow(.selected(true), isSelected: true) {
                Label("Star", systemImage: "star")
            }
            StyleListRow(.selected(false), isSelected: false) {
                Label("Circle", systemImage: "circle")
            }
            StyleListRow(.plain, isSelected: true) {
                Label("Circle", systemImage: "circle")
            }
            StyleListRow(.plain, isSelected: false) {
                Label("Circle", systemImage: "circle")
            }
            
            // System Rows for reference
            Label("Triangle", systemImage: "triangle")
            Label("Rectangle", systemImage: "rectangle")
        }
    }

}
