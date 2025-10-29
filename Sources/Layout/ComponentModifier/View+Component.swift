//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    /// Defines the View as a component to use it's style definition and draw the container.
    /// - Parameters:
    ///   - component: Definition to use for the component.
    ///   - containerHierarchy: Level of `.container` that should be used. Set to nil if no container should be visible.
    /// - Returns: A modified View.
    public func style(
        component: Style.ComponentDefinition,
        applyContainer: Style.Element.Hierarchy? = .primary, // TODO: Could be Bool now.
        state: Style.Container.InteractionState = .normal // TODO: This is only for the Container. Could be split?
    ) -> some View {
        Group {
            if let applyContainer, let container = component.container {
                self
                    .style(container: container, hierarchy: applyContainer, state: state)
            } else {
                self
            }
        }
        .modifier(ComponentModifier(component: component))
    }

}

private struct ComponentModifier: ViewModifier {

    @Environment(\.style) private var style

    let component: Style.ComponentDefinition

    func body(content: Content) -> some View {
        let stack = style.context.componentStack.appended(component)
        content
            .style(attribute: Style.Context.componentStack, value: stack)
    }

}
