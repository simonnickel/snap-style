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
        
        var hierarchy: SnapStyle.Element.Hierarchy {
            switch self {
                case .primary: .primary
                case .secondary: .secondary
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
            .style(padding: \.paddingActionButtonHorizontalAdditional, .horizontal)
            .style(
                component: .action,
                containerHierarchy: variant.hierarchy,
                state: configuration.isPressed ? .selected : state
            )
    }

}

public struct StyleButton<Content>: View where Content : View {


    // TODO: Bundle both together to just need a single var?
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

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
            let delay = style.number(for: \.animationInteractionHighlightDuration, in: styleContext) ?? 0
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
        .onHover(perform: { isHovering in
            self.isHovering = isHovering
        })
    }

}
