//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//


import SwiftUI

public struct StyleListRow<SelectionValue: Hashable, Content: View>: View {
    
    public enum Variant {
        case plain
        
        /// Navigation style.
        case navigate(_ value: SelectionValue)
        
        /// Selection style to choose a single value.
        case selectValue(_ value: SelectionValue, selection: Binding<SelectionValue>)
        
        /// Select style to choose multiple values.
        case selectValues(_ value: SelectionValue, selection: Binding<[SelectionValue]>)
        
        /// Selection style, controlled via binding.
        case selected(Binding<Bool>) // TODO: Is this Variant necessary? Should use enabled instead?
        
        /// Switch style, controlled via binding.
        case enabled(Binding<Bool>)
    }
    
    public typealias Action = () -> Void
    
    private let variant: Variant
    private let isSelected: Bool
    private let content: () -> Content
    private let action: Action?
    
    public init(
        _ variant: Variant = .plain,
        isSelected: Bool = false,
        action: Action? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.variant = variant
        self.isSelected = isSelected
        self.action = action
        self.content = content
    }
    /// An alternative init is required for variant that does not specify a `SelectionValue`.
    public init(
        _ variant: Variant = .plain,
        isSelected: Bool = false,
        action: Action? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) where SelectionValue == Never {
        self.variant = variant
        self.isSelected = isSelected
        self.action = action
        self.content = content
    }
    
    public var body: some View {
        Group {
            if case let .navigate(value) = variant {
                NavigationLink(value: value) {
                    viewContent(content, variant: variant)
                }
            } else {
                // TODO: Button Style
                Button {
                    if let action {
                        action()
                    } else {
                        // TODO: Haptic Feedback (Maybe as a semantic style key, to allow customisation)
                        switch variant {
                            case .plain: break
                            case .navigate(let _): break
                                
                            case .selectValue(let value, selection: let selection):
                                selection.wrappedValue = value
                                
                            case .selectValues(let value, selection: let selection):
                                if selection.wrappedValue.contains(value) {
                                    selection.wrappedValue.removeAll { $0 == value }
                                } else {
                                    selection.wrappedValue.append(value)
                                }
                                
                            case .selected(let isSelected): isSelected.wrappedValue.toggle()
                            case .enabled(let isEnabled): isEnabled.wrappedValue.toggle()
                        }
                    }
                } label: {
                    viewContent(content, variant: variant)
                }
            }
        }
//         .listRowInsets(.zero) // TODO: Configure ListRow inset.
        .style(listRowBackground: \.listRow)
        // TODO: Highlight on hover and navigation selection. Only use selected for actual selection.
        .style(component: .listRow, applyContainer: nil, state: isSelected ? .selected : .normal)
    }
    
    private func viewContent(_ content: @escaping () -> Content, variant: Variant) -> some View {
        // TODO: Customize Label to use \.spacingElements
        StyleHStack(spacing: \.spacingElements) {
            
            content()
            
            Spacer()
            
            viewAccessory(for: variant)
            
        }
        .style(composition: \.listRow, layers: [.foreground])
    }
    
    @ViewBuilder
    private func viewAccessory(for variant: Variant) -> some View {
        switch variant {
            case .plain: EmptyView()
                
            case .navigate(value: _): EmptyView()
                
            case .selectValue(let value, selection: let selection):
                // TODO: Apply font
                StyleIcon(value == selection.wrappedValue ? \.selectionOn : \.selectionOff)
                    .style(foreground: \.interactive)
                
            case .selectValues(let value, selection: let selection):
                // TODO: Apply font
                StyleIcon(selection.wrappedValue.contains(value) ? \.selectionOn : \.selectionOff)
                    .style(foreground: \.interactive)
                
            case .selected(let isSelected):
                // TODO: Apply font
                StyleIcon(isSelected.wrappedValue ? \.selectionOn : \.selectionOff)
                    .style(foreground: \.interactive)
                
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
    
    @ViewBuilder @MainActor
    func createSection(isSelected: Bool) -> some View {
        Section {
            StyleListRow(.navigate("Star"), isSelected: isSelected) {
                StyleLabel("Star", systemImage: "star")
            }
            StyleListRow(.selectValue("Rectangle", selection: .constant("Rectangle")), isSelected: isSelected) {
                StyleLabel("Rectangle", systemImage: "rectangle")
            }
            StyleListRow(.selectValue("Circle", selection: .constant("Star")), isSelected: isSelected) {
                StyleLabel("Circle", systemImage: "circle")
            }
            StyleListRow(.enabled(Binding(get: { true }, set: { _ in })), isSelected: isSelected) {
                StyleLabel("Triangle", systemImage: "triangle")
            }
            StyleListRow(.enabled(Binding(get: { false }, set: { _ in })), isSelected: isSelected) {
                StyleLabel("Pentagon", systemImage: "pentagon")
            }
            StyleListRow(.plain, isSelected: isSelected) {
                StyleLabel("Lines", systemImage: "line.horizontal.3")
            }
        } header: {
            StyleLabel("isSelected: \(isSelected)")
                .styleListSectionHeaderLabel()
        }
    }
    
    return NavigationStack {
        List {
            createSection(isSelected: false)
            createSection(isSelected: true)
            
            // System Rows for reference
            Section {
                StyleLabel("Triangle", systemImage: "triangle")
                Label("Rectangle", systemImage: "rectangle")
            } header: {
                StyleLabel("System Rows")
                    .styleListSectionHeaderLabel()
            }
        }
    }

}
