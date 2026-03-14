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
        if let mapping {
            // TODO: Should an explicit value of nil remove the value and no entry in the mapping just be ignored?
            self
                .style(define: Attribute.self, key: mapping(.any), for: .any)
                .style(define: Attribute.self, key: mapping(.title), for: .title)
                .style(define: Attribute.self, key: mapping(.label), for: .label)
                .style(define: Attribute.self, key: mapping(.icon), for: .icon)
                .style(define: Attribute.self, key: mapping(.value), for: .value)
                .style(define: Attribute.self, key: mapping(.accessory), for: .accessory)
                .style(define: Attribute.self, key: mapping(.separator), for: .separator)
                .style(define: Attribute.self, key: mapping(.footnote), for: .footnote)
        } else {
            self
        }
    }

}
