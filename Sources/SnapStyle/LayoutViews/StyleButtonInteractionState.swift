//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

/// A Button that provides a Binding to `SnapStyle.Component.InteractionState` that is updated on interaction.
public struct StyleButtonInteractionState<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    
    private var interactionState: Binding<SnapStyle.Component.InteractionState>
    
    @State private var isEnabled: Bool {
        didSet { update() }
    }
    @State private var isPressed: Bool = false {
        didSet { update() }
    }
    @State private var isHovering: Bool = false {
        didSet { update() }
    }

    private let action: () -> Void
    private let content: () -> Content

    public init(
        _ state: Binding<SnapStyle.Component.InteractionState>,
        enabled: Bool = true,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.interactionState = state
        self.isEnabled = enabled
        self.action = action
        self.content = content
    }

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
#if os(macOS)
        .onHover(perform: { isHovering in
            self.isHovering = isHovering
        })
#else
        .hoverEffect(.highlight, isEnabled: isEnabled)
#endif
    }
    
    private func update() {
        guard isEnabled else {
            interactionState.wrappedValue = .disabled
            return
        }
        
        if isPressed {
            interactionState.wrappedValue = .selected
        } else if isHovering {
            interactionState.wrappedValue = .highlighted
        } else {
            interactionState.wrappedValue = .normal
        }
    }

}


// MARK: - Preview

#Preview {
    @Previewable @State var state: SnapStyle.Component.InteractionState = .normal
    StyleButtonInteractionState($state, enabled: true) {
        
    } content: {
        Text("Button: \(state)")
    }

}
