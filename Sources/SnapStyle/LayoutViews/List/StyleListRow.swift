//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleListRow<SelectionValue: Hashable, Title: View, Content: View>: View {

    public typealias IconKeyPath = SnapStyle.IconKey.ValueBuilderKeyPath
    public typealias Action = () -> Void

    private let variant: Variant
    private let icon: StyleIcon.Definition?
    private let isSelected: Bool
    private let title: () -> Title
    private let content: (() -> Content)?
    private let action: Action?

    public init(
        _ variant: Variant = .plain,
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
        isSelected: Bool = false,
        action: Action? = nil,
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.variant = variant
        self.icon = .init(icon: icon, systemImage: systemImage)
        self.isSelected = isSelected
        self.action = action
        self.title = title
        self.content = content
    }

    /// An alternative init is required for variant that does not specify a `Content`.
    public init(
        _ variant: Variant = .plain,
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
        isSelected: Bool = false,
        action: Action? = nil,
        @ViewBuilder title: @escaping () -> Title
    ) where Content == Never {
        self.variant = variant
        self.icon = .init(icon: icon, systemImage: systemImage)
        self.isSelected = isSelected
        self.action = action
        self.title = title
        self.content = nil
    }

    /// An alternative init is required for variant that does not specify a `SelectionValue`.
    public init(
        _ variant: Variant = .plain,
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
        isSelected: Bool = false,
        action: Action? = nil,
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder content: @escaping () -> Content
    ) where SelectionValue == Never {
        self.variant = variant
        self.icon = .init(icon: icon, systemImage: systemImage)
        self.isSelected = isSelected
        self.action = action
        self.title = title
        self.content = content
    }

    /// An alternative init is required for variant that does not specify a `SelectionValue`, without a definition of Content.
    public init(
        _ variant: Variant = .plain,
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
        isSelected: Bool = false,
        action: Action? = nil,
        @ViewBuilder title: @escaping () -> Title
    ) where SelectionValue == Never, Content == Never {
        self.variant = variant
        self.icon = .init(icon: icon, systemImage: systemImage)
        self.isSelected = isSelected
        self.action = action
        self.title = title
        self.content = nil
    }

    public var body: some View {
        StyleVStack(spacing: \.spacingElements) {
            if case .navigate(let value) = variant {
                NavigationLink(value: value) {
                    viewTitle(title, variant: variant)
                }
            } else {
                viewButtonContainer(title, variant: variant)
            }

            content?()
                .insetListContent()
        }
        .environment(\.styleLabelSpacing, \.spacingListRowLeading)
        // TODO: Highlight on hover.
        // TODO: Highlight on control interaction?
        .style(component: .listRow, state: isSelected ? .highlighted : .normal)
    }


    // MARK: Action

    private func viewButtonContainer(_ content: @escaping () -> Title, variant: Variant) -> some View {
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
            viewTitle(title, variant: variant)
        }
    }


    // MARK: Content

    private func viewTitle(_ title: @escaping () -> Title, variant: Variant) -> some View {
        StyleHStack {

            StyleHStack(spacing: \.spacingListRowLeading) {
                if let icon {
                    StyleIcon(icon)
                        .style(element: .icon)
                        .listIconWidthSynchronized()
                }

                title()
            }

            StyleSpacer(minLength: \.spacingElements)

            viewAccessory(for: variant)

        }
        .style(composition: \.listRow, layers: [.foreground])
    }


    // MARK: Accessory

    @ViewBuilder
    private func viewAccessory(for variant: Variant) -> some View {
        switch variant {
            case .plain: EmptyView()

            case .navigate(value: _): EmptyView()

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
                        Toggle(isOn: isOn) {
                            EmptyView()
                        }
                    }
        }
    }


    // MARK: Variant

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
}


// MARK: - Preview

#Preview {

    @ViewBuilder @MainActor
    func createSection(isSelected: Bool) -> some View {
        Section {
            StyleListRow(
                .navigate("Star"),
                systemImage: "star",
                isSelected: isSelected
            ) {
                Text("Star")
            }
            StyleListRow(
                .selectValue("Rectangle", selection: .constant("Rectangle")),
                systemImage: "rectangle",
                isSelected: isSelected
            ) {
                Text("Rectangle")
            }
            StyleListRow(
                .selectValue("Circle", selection: .constant("Star")),
                systemImage: "circle",
                isSelected: isSelected
            ) {
                Text("Circle")
            }
            StyleListRow(
                .enabled(Binding(get: { true }, set: { _ in })),
                systemImage: "triangle",
                isSelected: isSelected
            ) {
                Text("Triangle")
            }
            StyleListRow(
                .enabled(Binding(get: { false }, set: { _ in })),
                systemImage: "pentagon",
                isSelected: isSelected
            ) {
                Text("Pentagon")
            }
            StyleListRow(
                .plain,
                systemImage: "line.horizontal.3",
                isSelected: isSelected
            ) {
                Text("Lines")
            }
            StyleListRow(
                .plain,
                systemImage: "square",
                isSelected: isSelected
            ) {
                Text("With Content")
            } content: {
                Rectangle()
            }
        } header: {
            StyleLabel("isSelected: \(isSelected)")
                .styleListSectionHeaderLabel()
        }
    }

    return NavigationStack {
        StyleList {
            createSection(isSelected: false)
            createSection(isSelected: true)

        }
        List {
            // System Rows for reference
            Section {
                Label("Pentagon", systemImage: "pentagon")
                Label("Rectangle", systemImage: "rectangle")
                Label("Triangle", systemImage: "triangle")
            } header: {
                StyleLabel("System Rows")
                    .styleListSectionHeaderLabel()
            }
        }
    }

}
