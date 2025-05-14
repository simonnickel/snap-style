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
        case enabled(Binding<Bool>)
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
        Group {
            if case let .navigate(value) = mode {
                NavigationLink(value: value) {
                    viewContent(content, mode: mode)
                }
            } else {
                viewContent(content, mode: mode)
            }
        }
        // .listRowInsets(.zero) // TODO: Configure ListRow inset.
        .style(listRowBackground: \.interactiveListRow)
        // TODO: Highlight on hover and navigation selection. Only use selected for actual selection.
        .style(component: .listRow, applyContainer: nil, state: isSelected ? .selected : .normal)
    }
    
    private func viewContent(_ content: @escaping () -> Content, mode: Mode) -> some View {
        // TODO: Customize Label to use \.spacingElements
        StyleHStack(spacing: \.spacingElements) {
            
            content()
            
            Spacer()
            
            viewAccessory(for: mode)
            
        }
    }
    
    @ViewBuilder
    private func viewAccessory(for mode: Mode) -> some View {
        switch mode {
            case .plain: EmptyView()
                
            case .navigate(value: _): EmptyView()
                
            case .selected(let isSelected):
                // TODO: Apply font and color
                StyleIcon(isSelected ? \.selectionOn : \.selectionOff)
                
            case .enabled(let isOn):
                // TODO: Use styled toggle and enable full row interaction
                Toggle(isOn: isOn) {
                    EmptyView()
                }
                
        }
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
            StyleListRow(.enabled(Binding(get: { true }, set: { _ in })), isSelected: true) {
                Label("Star", systemImage: "star")
            }
            StyleListRow(.enabled(Binding(get: { false }, set: { _ in })), isSelected: true) {
                Label("Circle", systemImage: "circle")
            }
            StyleListRow(.plain, isSelected: true) {
                Label("Star", systemImage: "star")
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
