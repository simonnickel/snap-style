//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

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
            // TODO: This additional padding should be part of the container padding.
            .style(padding: \.paddingActionButtonHorizontalAdditional, .horizontal)
            .style(
                component: variant.component,
                containerHierarchy: variant.hierarchy,
                state: configuration.isPressed ? .selected : state
            )
    }

}

public struct StyleButton<Content>: View where Content : View {

    @Environment(\.style) private var style

    private let variant: StyleButtonStyle.Variant
    @State private var isEnabled: Bool
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

    @State private var isPressed: Bool = false
    @State private var isHovering: Bool = false

    public var body: some View {
        Button {
            guard isEnabled else { return }

            action()

            // TODO FB: It should be enough to rely on `withAnimation(.smooth.delay(delay))`, but it does not get triggered consistently.
            isPressed = true
            let delay = style.number(for: \.animationInteractionHighlightDuration) ?? 0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.smooth) {
                    isPressed = false
                }
            }
        } label: {
            content()
        }
        .disabled(!isEnabled)
        .buttonStyle(
            StyleButtonStyle(variant, state: [
                isEnabled ? .normal : .disabled,
                isPressed ? .selected : .normal,
                isHovering ? .highlighted : .normal,
            ].max() ?? .normal)
        )
#if os(macOS)
        .onHover(perform: { isHovering in
            self.isHovering = isHovering
        })
#else
        .hoverEffect(.highlight, isEnabled: isEnabled)
#endif
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
