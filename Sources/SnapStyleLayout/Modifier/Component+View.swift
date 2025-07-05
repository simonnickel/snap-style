//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

extension View {

    /// Defines the View as a component to use it's style definition and draw the container.
    /// - Parameters:
    ///   - component: Definition to use for the component.
    ///   - containerHierarchy: Level of `.container` that should be used. Set to nil if no container should be visible.
    /// - Returns: A modified View.
    public func style(
        component: SnapStyle.ComponentDefinition,
        applyContainer: SnapStyle.Element.Hierarchy? = .primary,
        state: SnapStyle.Component.InteractionState = .normal
    ) -> some View {
        Group {
            if let applyContainer {
                self
                    .style(element: .container, hierarchy: applyContainer)
            } else {
                self
            }
        }
        .modifier(ComponentModifier(component: component, state: state))
    }

}

// TODO iOS26: Remove iOS 18 Variant
internal struct ComponentModifier: ViewModifier {

    let component: SnapStyle.ComponentDefinition
    let state: SnapStyle.Component.InteractionState

    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .modifier(ComponentModifier26(component: component, state: state))
        } else {
            content
                .modifier(ComponentModifier18(component: component, state: state))
        }
    }
}

internal struct ComponentModifier26: ViewModifier {

    @Environment(\.style) private var style

    let component: SnapStyle.ComponentDefinition
    let state: SnapStyle.Component.InteractionState

    func body(content: Content) -> some View {
        let componentStack = style.context.componentStack.appended(component, state: state)
        content
            .style(attribute: SnapStyle.Context.componentStack, value: componentStack)
    }

}

internal struct ComponentModifier18: ViewModifier {

    @Environment(\.style) private var style

    let component: SnapStyle.ComponentDefinition
    let state: SnapStyle.Component.InteractionState

    /// Internal copy to apply animation on changes.
    @State private var stateInternal: SnapStyle.Component.InteractionState = .normal

    func body(content: Content) -> some View {
        let componentStack = style.context.componentStack.appended(component, state: stateInternal)
        content
            .style(attribute: SnapStyle.Context.componentStack, value: componentStack)
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
