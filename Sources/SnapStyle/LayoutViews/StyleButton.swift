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
                state: configuration.isPressed ? .highlighted : state
            )
    }
    
}

public struct StyleButton<Content>: View where Content : View {

    
    // TODO: Bundle both together to just need a single var?
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let variant: StyleButtonStyle.Variant
    @State private var state: SnapStyle.Component.InteractionState
    private let action: () -> Void
    private let content: () -> Content
    
    public init(
        _ variant: StyleButtonStyle.Variant = .primary,
        state: SnapStyle.Component.InteractionState = .normal,
        _ action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.variant = variant
        self.state = state
        self.action = action
        self.content = content
    }
    
    @State private var highlighted: Bool = false
    
    public var body: some View {
        Button {
            guard state != .disabled else { return }

            action()
            
            // TODO FB: It should be enough to rely on `withAnimation(.smooth.delay(delay))`, but it does not get triggered consistently.
            state = .highlighted
            let delay = style.number(for: \.animationInteractionHighlightDuration, in: styleContext) ?? 0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.smooth) {
                    state = .normal
                }
            }
        } label: {
            content()
        }
        .disabled(state == .disabled)
        .buttonStyle(StyleButtonStyle(variant, state: state))
    }
    
}
