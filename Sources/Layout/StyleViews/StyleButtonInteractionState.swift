//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

/// A Button that provides a Binding to `Style.Component.InteractionState` that is updated on interaction.
public struct StyleButtonInteractionState<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    
    private var interactionState: Binding<Style.Component.InteractionState>

    struct StateSet: Equatable {
        var didPress: Bool = false
        var isPressed: Bool = false
        var isHovering: Bool = false

        var result: Style.Component.InteractionState {
            if isPressed || didPress {
                return .selected
            }

            if isHovering {
                return .highlighted
            }

            return .normal
        }
    }

    @State private var stateSet: StateSet = .init()

    private let action: () -> Void
    private let content: () -> Content

    public init(
        _ state: Binding<Style.Component.InteractionState>,
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

            stateSet.didPress = true
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                stateSet.didPress = false
            }
        } label: {
            content()
        }
        .buttonStyle(IsPressedButtonStyle(isPressed: $stateSet.isPressed))
        .onChange(of: stateSet, initial: true) { oldValue, newValue in
            update()
        }
#if os(macOS)
        .onHover(perform: { isHovering in
            stateSet.isHovering = isHovering
        })
#else
        .hoverEffect(.highlight) // , isEnabled: isEnabled
#endif
    }

    private func update() {
        withAnimation(.snappy) {
            let current = stateSet.result
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
    @Previewable @State var state: Style.Component.InteractionState = .normal
    
    StyleButtonInteractionState($state) {

    } content: {
        Text("Button: \n\(state)")
            .padding()
            .background(state == .normal ? .yellow : .orange)
    }

}
