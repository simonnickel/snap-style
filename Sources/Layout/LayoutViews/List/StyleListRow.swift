//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI

public typealias StyleListRow = Style.Views.List.Row.RowView
extension Style.Views.List {
    public enum Row {}
}

extension Style.Views.List.Row {
    
    public struct RowView<SelectionValue: Hashable, Title: View, Content: View>: View {
        
        @Environment(\.controlState) private var controlState
        
        public typealias Action = () -> Void
        
        private let variant: Style.Views.List.Row.Variant<SelectionValue>
        private let icon: StyleIcon.Definition?
        private let title: () -> Title
        private let content: (() -> Content)?
        private let action: Action?
        
        public init(
            _ variant: Style.Views.List.Row.Variant<SelectionValue> = .plain,
            icon: Style.Keys.Icon.ValueBuilderKeyPath? = nil,
            systemImage: String? = nil,
            action: Action? = nil,
            @ViewBuilder title: @escaping () -> Title,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.variant = variant
            self.icon = .init(icon: icon, systemImage: systemImage)
            self.action = action
            self.title = title
            self.content = content
        }
        
        /// An alternative init is required for variant that does not specify a `Content`.
        public init(
            _ variant: Style.Views.List.Row.Variant<SelectionValue> = .plain,
            icon: Style.Keys.Icon.ValueBuilderKeyPath? = nil,
            systemImage: String? = nil,
            action: Action? = nil,
            @ViewBuilder title: @escaping () -> Title
        ) where Content == Never {
            self.variant = variant
            self.icon = .init(icon: icon, systemImage: systemImage)
            self.action = action
            self.title = title
            self.content = nil
        }
        
        /// An alternative init is required for variant that does not specify a `SelectionValue`.
        public init(
            _ variant: Style.Views.List.Row.Variant<SelectionValue> = .plain,
            icon: Style.Keys.Icon.ValueBuilderKeyPath? = nil,
            systemImage: String? = nil,
            action: Action? = nil,
            @ViewBuilder title: @escaping () -> Title,
            @ViewBuilder content: @escaping () -> Content
        ) where SelectionValue == Never {
            self.variant = variant
            self.icon = .init(icon: icon, systemImage: systemImage)
            self.action = action
            self.title = title
            self.content = content
        }
        
        /// An alternative init is required for variant that does not specify a `SelectionValue`, without a definition of `Content`.
        public init(
            _ variant: Style.Views.List.Row.Variant<SelectionValue> = .plain,
            icon: Style.Keys.Icon.ValueBuilderKeyPath? = nil,
            systemImage: String? = nil,
            action: Action? = nil,
            @ViewBuilder title: @escaping () -> Title
        ) where SelectionValue == Never, Content == Never {
            self.variant = variant
            self.icon = .init(icon: icon, systemImage: systemImage)
            self.action = action
            self.title = title
            self.content = nil
        }
        
        @State private var state: Style.Component.InteractionState = .normal
        
        private var interactionState: Style.Component.InteractionState {
            switch controlState {
                case .disabled: .disabled
                case .inactive: .inactive
                case .active: state
            }
        }
        
        
        // MARK: - Body
        
        public var body: some View {
            switch variant {
                case .plain, .pick, .pickInline:
                    viewRow()
                        .style(component: .listRow, state: interactionState)
                    
                    // TODO macOS: navigation style and hover highlight.
                case .navigate(let value, let isPresented):
                    StyleListRowNavigationHighlightContainer(
                        interactionState: interactionState,
                        isPresented: isPresented
                    ) {
                        NavigationLink(value: value) {
                            viewRow()
                        }
                    }
                    
                case .navigation(let isPresented):
                    StyleListRowNavigationHighlightContainer(
                        interactionState: interactionState,
                        isPresented: isPresented
                    ) {
                        viewButtonContainer {
                            viewRow()
                        }
                    }
                    
                default:
                    viewButtonContainer {
                        viewRow()
                            .style(component: .listRow, state: interactionState)
                    }
            }
        }
        
        
        // MARK: Action
        
        private func viewButtonContainer<ContainerContent: View>(content: @escaping () -> ContainerContent) -> some View {
            StyleButtonInteractionState(
                $state,
                action: {
                    if let action {
                        action()
                    } else {
                        // TODO feature: Haptic Feedback (Maybe as a semantic style key, to allow customisation)
                        switch variant {
                            case .plain: break
                            case .navigate, .navigation: break
                                                                
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
                            case .pick, .pickInline: break
                        }
                    }
                },
                content: content
            )
        }
        
        
        // MARK: Content
        
        private func viewRow() -> some View {
            StyleStack(spacing: \.spacingGroups) {
                StyleStack(.horizontal) {
                    
                    StyleStack(.horizontal, spacing: \.paddingListRowLeading) {
                        if let icon {
                            StyleIcon(icon)
                                .style(element: .icon)
                                .listIconWidthSynchronized()
                        }
                        
                        title()
                    }
                    
                    StyleSpacer(min: \.spacingElements)
                    
                    viewAccessory(for: variant)
                    
                }
                .style(composition: \.listRow, layers: [.foreground])
                
                viewContent()
                    .applyListContentInset()
            }
            .contentShape(.rect)
            .environment(\.styleLabelSpacing, \.paddingListRowLeading)
        }
        
        @ViewBuilder
        private func viewContent() -> some View {
            switch variant {
                case .pickInline(let values, titleKeyPath: let titleKeyPath, selection: let selection):
                    // TODO FB12181540: Should be able to apply color and font to Picker.
                    Picker("", selection: selection) {
                        ForEach(values, id: \.self) { value in
                            Text("\(value[keyPath: titleKeyPath])")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                default: content?()
            }
        }
        
        
        // MARK: Accessory
        
        @ViewBuilder
        private func viewAccessory(for variant: Style.Views.List.Row.Variant<SelectionValue>) -> some View {
            switch variant {
                case .plain: EmptyView()
                    
                case .navigate(value: _): EmptyView()
                    
                case .navigation(_):
                    StyleIcon(\.indicatorNavigation)
                        .style(font: \.listAccessoryNavigation)
                        .style(foreground: \.indicatorNavigation)
                    
                case .selectValue(let value, selection: let selection):
                    StyleIcon(value == selection.wrappedValue ? \.selectionOn : \.selectionOff)
                        .style(element: .accessory)
                    
                case .selectValues(let value, selection: let selection):
                    StyleIcon(selection.wrappedValue.contains(value) ? \.selectionOn : \.selectionOff)
                        .style(element: .accessory)
                    
                case .selected(let isSelected):
                    StyleIcon(isSelected.wrappedValue ? \.selectionOn : \.selectionOff)
                        .style(element: .accessory)
                    
                case .enabled(let isOn):
                    // Placed in an overlay to not influence the rows height.
                    ZStack {}
                        .overlay(alignment: .trailing) {
                            // TODO: tint color
                            Toggle(isOn: isOn) {
                                EmptyView()
                            }
                        }
                    
                case .pick(let values, let titleKeyPath, selection: let selection):
                    // TODO FB12181540: Should be able to apply color and font to Picker.
                    Picker("", selection: selection) {
                        ForEach(values, id: \.self) { value in
                            Text("\(value[keyPath: titleKeyPath])")
                        }
                    }
                    .labelsHidden()
                    // Removed padding to not influence the rows height.
                    .padding(.vertical, -10)
                    // TODO FB19360250: Setting .menu explicitly disables full row interaction. Default is .menu anyway.
                    // TODO FB19360025: Need to set .menu explicitly to apply tint color, but this would prevent full row interaction (FB19360250).
                    // .pickerStyle(.menu)
                    
                case .pickInline(let values, let titleKeyPath, selection: let selection): EmptyView()

            }
        }
    }
    
}


// MARK: - Preview

#Preview {
    
    @Previewable @State var state: ViewControlState = .active

    Picker("ControlState", selection: $state) {
        ForEach(ViewControlState.allCases, id: \.self) { value in
            Text(value.rawValue)
        }
    }
    .pickerStyle(.segmented)
    
    NavigationStack {
        StyleList {
            Section {
                
                StyleListRow(
                    .navigate("Star"),
                    systemImage: "star"
                ) {
                    Text("Star")
                }
                StyleListRow(
                    .navigation(isPresented: false),
                    systemImage: "staroflife"
                ) {
                    Text("Staroflife")
                }
                StyleListRow(
                    .selectValue("Rectangle", selection: .constant("Rectangle")),
                    systemImage: "rectangle"
                ) {
                    Text("Rectangle")
                }
                StyleListRow(
                    .selectValue("Circle", selection: .constant("Star")),
                    systemImage: "circle"
                ) {
                    Text("Circle")
                }
                StyleListRow(
                    .enabled(Binding(get: { true }, set: { _ in })),
                    systemImage: "triangle"
                ) {
                    Text("Triangle")
                }
                StyleListRow(
                    .enabled(Binding(get: { false }, set: { _ in })),
                    systemImage: "pentagon"
                ) {
                    Text("Pentagon")
                }
                StyleListRow(
                    .pick(["A", "B"], titleKeyPath: \.self, selection: Binding(get: { "A" }, set: { _ in })),
                    systemImage: "square"
                ) {
                    Text("With Content")
                }
                StyleListRow(
                    .pickInline(["A", "B"], titleKeyPath: \.self, selection: Binding(get: { "A" }, set: { _ in })),
                    systemImage: "square"
                ) {
                    Text("With Content")
                }
                StyleListRow(
                    .plain,
                    systemImage: "line.horizontal.3"
                ) {
                    Text("Lines")
                }
                StyleListRow(
                    .plain,
                    systemImage: "square"
                ) {
                    Text("With Content")
                } content: {
                    Rectangle()
                }
                .insetListContent()
                StyleListRow(
                    .plain,
                    systemImage: "square"
                ) {
                    Text("With Content")
                } content: {
                    Rectangle()
                }
            } header: {
                StyleLabel("Section")
                    .styleListSectionHeaderLabel()
            }
            .controlState(state)
        }
//        List {
//            // System Rows for reference
//            Section {
//                Label("Pentagon", systemImage: "pentagon")
//                Label("Rectangle", systemImage: "rectangle")
//                Label("Triangle", systemImage: "triangle")
//            } header: {
//                StyleLabel("System Rows")
//                    .styleListSectionHeaderLabel()
//            }
//        }
    }

}
