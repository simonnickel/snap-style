//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

/// A Button that provides a Binding to `SnapStyle.Component.InteractionState` that is updated on interaction.
public struct StyleButtonInteractionState<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    
    private var interactionState: Binding<SnapStyle.Component.InteractionState>

    struct StateSet: Equatable {
        var didPress: Bool = false
        var isPressed: Bool = false
        var isHovering: Bool = false

        var result: SnapStyle.Component.InteractionState {
            if isPressed || didPress {
                return .selected
            }

            if isHovering {
                return .highlighted
            }

            return .normal
        }
    }

    @State private var state: StateSet = .init()

    private let action: () -> Void
    private let content: () -> Content

    public init(
        _ state: Binding<SnapStyle.Component.InteractionState>,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.interactionState = state
        self.action = action
        self.content = content
    }

    private var delay: Double {
        style.number(for: \.animationInteractionHighlightDuration) ?? 0
    }

    public var body: some View {
        Button {
            action()

            state.didPress = true
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                state.didPress = false
            }
        } label: {
            content()
        }
        .buttonStyle(IsPressedButtonStyle(isPressed: $state.isPressed))
        .onChange(of: state, initial: true) { oldValue, newValue in
            update()
        }
#if os(macOS)
        .onHover(perform: { isHovering in
            self.state.isHovering = isHovering
        })
#else
        .hoverEffect(.highlight) // , isEnabled: isEnabled
#endif
    }

    private func update() {
        withAnimation(.snappy) {
            let current = state.result
            interactionState.wrappedValue = current
        }
    }

}


// MARK: - IsPressedButtonStyle

struct IsPressedButtonStyle: ButtonStyle {

    @Binding var isPressed: Bool

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed, initial: true) { oldValue, newValue in
                isPressed = newValue
            }
    }

}


// MARK: - Preview

#Preview {
    @Previewable @State var state: SnapStyle.Component.InteractionState = .normal
    
    StyleButtonInteractionState($state) {

    } content: {
        Text("Button: \n\(state)")
            .padding()
            .background(state == .normal ? .yellow : .orange)
    }

}
