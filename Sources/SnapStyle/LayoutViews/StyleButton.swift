//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI


// MARK: - StyleButtonStyle

public struct StyleButtonStyle: ButtonStyle {
    
    public enum Variant {
        case primary
        case secondary
        case icon(hierarchy: SnapStyle.Element.Hierarchy = .primary)
        case component(SnapStyle.ComponentDefinition, hierarchy: SnapStyle.Element.Hierarchy = .primary)
        
        var component: SnapStyle.ComponentDefinition {
            switch self {
                case .primary, .secondary: .action
                case .icon: .actionIcon
                case .component(let component, hierarchy: _): component
            }
        }
        
        var hierarchy: SnapStyle.Element.Hierarchy {
            switch self {
                case .primary: .primary
                case .secondary: .secondary
                case .icon(let hierarchy): hierarchy
                case .component(_, hierarchy: let hierarchy): hierarchy
            }
        }
    }
    
    private let variant: Variant
    private let state: SnapStyle.Component.InteractionState

    public init(_ variant: Variant, state: SnapStyle.Component.InteractionState) {
        self.variant = variant
        self.state = state
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .style(
                component: variant.component,
                applyContainer: variant.hierarchy,
                state: configuration.isPressed ? .selected : state
            )
    }

}


// MARK: - StyleButton

public struct StyleButton<Content>: View where Content : View {

    @Environment(\.style) private var style

    private let variant: StyleButtonStyle.Variant
    
    private let isEnabled: Bool
    @State private var interactionState: SnapStyle.Component.InteractionState = .normal

    private let action: () -> Void
    private let content: () -> Content

    public init(
        _ variant: StyleButtonStyle.Variant = .primary,
        enabled: Bool = true,
        _ action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.variant = variant
        self.isEnabled = enabled
        self.action = action
        self.content = content
    }

    public var body: some View {
        StyleButtonInteractionState($interactionState, enabled: isEnabled, action: action, content: content)
            .buttonStyle(
                StyleButtonStyle(variant, state: interactionState)
            )
    }

}


// MARK: - Preview

#if DEBUG

struct PreviewContent: View {

    let isEnabled: Bool

    var body: some View {
        StyleStack(spacing: \.spacingGroups, alignmentV: .center) {
            StyleButton(.primary, enabled: isEnabled) { } content: {
                Label("Primary", systemImage: "star")
            }
            StyleButton(.secondary, enabled: isEnabled) { } content: {
                Label("Secondary", systemImage: "star")
            }
            StyleStack(.horizontal, spacing: \.spacingElements) {
                StyleButton(.icon(hierarchy: .primary), enabled: isEnabled) { } content: {
                    Label("Primary", systemImage: "star")
                        .labelStyle(.iconOnly)
                }
                StyleButton(.icon(hierarchy: .secondary), enabled: isEnabled) { } content: {
                    Label("Secondary", systemImage: "star")
                        .labelStyle(.iconOnly)
                }
                StyleButton(.icon(hierarchy: .tertiary), enabled: isEnabled) { } content: {
                    Label("Teriary", systemImage: "star")
                        .labelStyle(.iconOnly)
                }
            }
            StyleButton(.component(.valueCard), enabled: isEnabled) { } content: {
                Label("Component: .valueCard", systemImage: "star")
            }
        }
    }
}

#Preview {
    
    @Previewable @State var isEnabled: Bool = true

    StyleScreen {
        PreviewContent(isEnabled: isEnabled)
            .style(component: .contentCard)
        PreviewContent(isEnabled: isEnabled)
            .style(component: .accentCard)

        Toggle(isOn: $isEnabled) {
            Text("enabled")
        }
    }
}

#endif
