//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI


// MARK: - ViewModifier

extension View {
    
    /// Set value of a `Context` attribute for use in Environment.
    public func styleContextBase() -> some View {
        self
            .modifier(ContextBaseModifier())
    }
    
    /// Set value of a `Context` attribute for use in Environment.
    public func style<Key: Hashable, Value: Hashable>(attribute: SnapStyle.Context.Attribute<Key, Value>, value: Value) -> some View {
        self
            .modifier(ContextAttributeModifier(attribute: attribute, value: value))
    }
    
}

internal struct ContextBaseModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: colorScheme, for: SnapStyle.Context.colorScheme)
        content
            .style(update: context)
    }
    
}

internal struct ContextAttributeModifier<Key: Hashable, Value: Hashable>: ViewModifier {
    
    @Environment(\.style) private var style

    let attribute: SnapStyle.Context.Attribute<Key, Value>
    let value: Value

    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: value, for: attribute)
        content
            .style(update: context)
    }
    
}
