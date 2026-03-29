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
        .style(spacing: component.spacing?())
    }
    
    private func setupAttributes<Attribute: StyleElementAttribute>(with mapping: Style.Component.Mapping<Attribute>?) -> some View {

        // Make sure to clear values even if no mapping is defined.
        self
            .style(define: .any, key: mapping?(.any), shouldClear: true)
            .style(define: .title, key: mapping?(.title), shouldClear: true)
            .style(define: .label, key: mapping?(.label), shouldClear: true)
            .style(define: .icon, key: mapping?(.icon), shouldClear: true)
            .style(define: .value, key: mapping?(.value), shouldClear: true)
            .style(define: .accessory, key: mapping?(.accessory), shouldClear: true)
            .style(define: .separator, key: mapping?(.separator), shouldClear: true)
            .style(define: .footnote, key: mapping?(.footnote), shouldClear: true)
    }

}


