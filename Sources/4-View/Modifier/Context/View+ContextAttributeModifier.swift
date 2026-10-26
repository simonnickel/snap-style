//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

extension View {

    /// Set the value of a `Context.Attribute`. Inert value: `nil`, keeps the value from `Context`.
    public func style<Key: Hashable, Value: Hashable>(attribute: Style.Context.Attribute<Key, Value>, value: Value?) -> some View {
        modifier(ContextAttributeModifier(attribute: attribute, value: value))
    }

}

private struct ContextAttributeModifier<Key: Hashable, Value: Hashable>: ViewModifier {

    @Environment(\.style) private var style

    let attribute: Style.Context.Attribute<Key, Value>
    let value: Value?

    func body(content: Content) -> some View {
        let context = value.map { style.context.withAttribute(value: $0, for: attribute) } ?? style.context
        content
            .style(update: context)
    }

}
