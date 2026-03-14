//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

extension View {

    /// Defines the View as a component and applies the style definitions and container.
    /// - Parameters:
    ///   - component: `Component` to use for the View.
    ///   - state: `InteractionState` the container is in.
    /// - Returns: View with adjusted `Context` and applied Container.
    public func style(
        component: Style.Component,
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
        .setupAttributes(with: component.fonts)
        .setupAttributes(with: component.compositions)
        .setupAttributes(with: component.shapes)
        .setupAttributes(with: component.paddings)
        .style(attribute: Style.Context.component, value: component)
    }
    
    @ViewBuilder
    package func setupAttributes<Attribute: StyleElementAttribute>(with mapping: Style.Component.Mapping<Attribute>?) -> some View {
        
        // Make sure to clear values even if no mapping is defined.
        let map = mapping ?? { _ in nil }
        self
            .style(define: .any, key: map(.any), shouldClear: true)
            .style(define: .title, key: map(.title), shouldClear: true)
            .style(define: .label, key: map(.label), shouldClear: true)
            .style(define: .icon, key: map(.icon), shouldClear: true)
            .style(define: .value, key: map(.value), shouldClear: true)
            .style(define: .accessory, key: map(.accessory), shouldClear: true)
            .style(define: .separator, key: map(.separator), shouldClear: true)
            .style(define: .footnote, key: map(.footnote), shouldClear: true)
    }

}
