//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    /// Defines the View as a component and applies the style definitions and container.
    /// - Parameters:
    ///   - component: `ComponentDefinition` to use for the component.
    ///   - state: `InteractionState` the container is in.
    /// - Returns: View with adjusted `Context` and applied Container.
    public func style(
        component: Style.ComponentDefinition,
        state: Style.Container.InteractionState = .normal
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
