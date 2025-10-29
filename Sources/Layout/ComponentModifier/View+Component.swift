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
        state: Style.Container.InteractionState = .normal // TODO: Only for Container, could be split?
    ) -> some View {
        Group {
            if let container = component.container {
                self
                    .style(container: container, state: state)
            } else {
                self
            }
        }
        .style(attribute: Style.Context.component, value: component)
    }

}
