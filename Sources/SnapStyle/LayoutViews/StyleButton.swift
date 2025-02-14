//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleButtonStyle: ButtonStyle {
    
    let state: [SnapStyle.Context.StateAttribute]
    
    public init(state: [SnapStyle.Context.StateAttribute] = []) {
        self.state = state
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .style(component: .action)
            .style(state: .highlighted, value: configuration.isPressed || state.contains(.highlighted))
    }
    
}

public struct StyleButton<Content>: View where Content : View {
    
    // TODO: Bundle both together to just need a single var?
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let action: () -> Void
    private let content: () -> Content
    
    public init(
        _ action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
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
        .buttonStyle(StyleButtonStyle(state: highlighted ? [.highlighted] : []))
    }
    
}
