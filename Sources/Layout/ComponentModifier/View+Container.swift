//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    /// Applies the container.
    /// - Parameters:
    ///   - container: `ContainerDefinition` to use.
    ///   - state: `InteractionState` the container is in.
    /// - Returns: View with applied Container.
    public func style(
        container: Style.ContainerDefinition,
        state: Style.Container.InteractionState = .normal
    ) -> some View {
        self
            .style(container: container)
            .modifier(ContainerModifier(container: container, state: state))
    }

}

// TODO iOS26: Remove iOS 18 Variant
private struct ContainerModifier: ViewModifier {

    let container: Style.ContainerDefinition
    let state: Style.Container.InteractionState

    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .modifier(ContainerModifier26(container: container, state: state))
        } else {
            content
                .modifier(ContainerModifier18(container: container, state: state))
        }
    }
}

private struct ContainerModifier26: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.ContainerDefinition
    let state: Style.Container.InteractionState

    func body(content: Content) -> some View {
        let stack = style.context.containerStack.appended(container, state: state)
        content
            .style(accent: container.requiresSecondaryAccent ? \.secondary : nil)
            .style(attribute: Style.Context.containerStack, value: stack)
    }

}

private struct ContainerModifier18: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.ContainerDefinition
    let state: Style.Container.InteractionState

    /// Internal copy to apply animation on changes.
    @State private var stateInternal: Style.Container.InteractionState = .normal

    func body(content: Content) -> some View {
        let stack = style.context.containerStack.appended(container, state: stateInternal)
        content
            .style(attribute: Style.Context.containerStack, value: stack)
            .onChange(of: state, initial: true) { oldValue, newValue in
                // TODO FB: (iOS 18) Need to delay to prevent from SwiftUI skipping animations. Happens e.g. when pushing a screen on a NavigationStack.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation {
                        stateInternal = newValue
                    }
                }
            }
    }

}
