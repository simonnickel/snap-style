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
    private let isHighlighted: Bool

    public init(_ variant: Variant, isHighlighted: Bool) {
        self.variant = variant
        self.isHighlighted = isHighlighted
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .style(padding: \.paddingActionButtonHorizontalAdditional, .horizontal)
            .style(component: .action, containerHierarchy: variant.hierarchy) // TODO: Apply highlight
//            .style(state: .highlighted, value: configuration.isPressed || state.contains(.highlighted))
    }
    
}

public struct StyleButton<Content>: View where Content : View {

    
    // TODO: Bundle both together to just need a single var?
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let variant: StyleButtonStyle.Variant
    private let action: () -> Void
    private let content: () -> Content
    
    public init(
        _ variant: StyleButtonStyle.Variant = .primary,
        _ action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.variant = variant
        self.action = action
        self.content = content
    }
    
    @State private var highlighted: Bool = false
    
    public var body: some View {
        Button {
            action()
            
            // TODO FB: It should be enough to rely on `withAnimation(.smooth.delay(delay))`, but it does not get triggered consistently.
            highlighted = true
            let delay = style.number(for: \.animationInteractionHighlightDuration, in: styleContext) ?? 0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.smooth) {
                    highlighted = false
                }
            }
        } label: {
            content()
        }
        .buttonStyle(StyleButtonStyle(variant, isHighlighted: highlighted))
    }
    
}
