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
        case component(SnapStyle.ComponentDefinition, hierarchy: SnapStyle.Element.Hierarchy = .primary)
        
        var component: SnapStyle.ComponentDefinition {
            switch self {
                case .primary, .secondary: .action
                case .component(let component, hierarchy: _): component
            }
        }
        
        var hierarchy: SnapStyle.Element.Hierarchy {
            switch self {
                case .primary: .primary
                case .secondary: .secondary
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

#Preview {
    StyleScreen {
        StyleVStack(spacing: \.spacingElements, alignment: .center) {
            StyleButton(.primary, enabled: true) { } content: {
                Label("Primary", systemImage: "star")
            }
            StyleButton(.secondary, enabled: true) { } content: {
                Label("Secondary", systemImage: "star")
            }
            StyleButton(.component(.content), enabled: true) { } content: {
                Label("Secondary", systemImage: "star")
            }
        }
        .style(component: .content)
    }
}
