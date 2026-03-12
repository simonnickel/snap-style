//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    /// Set the value of a `Context.Attribute`.
    public func style<Key: Hashable, Value: Hashable>(attribute: Style.Context.Attribute<Key, Value>, value: Value) -> some View {
        modifier(ContextAttributeModifier(attribute: attribute, value: value))
    }

}

private struct ContextAttributeModifier<Key: Hashable, Value: Hashable>: ViewModifier {

    @Environment(\.style) private var style

    let attribute: Style.Context.Attribute<Key, Value>
    let value: Value

    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: value, for: attribute)
        content
            .style(update: context)
    }

}
