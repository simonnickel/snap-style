//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension EnvironmentValues {
    
    @Entry public var styleContext: SnapStyle.Context = .init()

}


// MARK: - ViewModifier

extension View {
    
    /// Set value of a `Context` attribute for use in Environment.
    public func style<Key: Hashable, Value: Hashable>(attribute: SnapStyle.Context.Attribute<Key, Value>, value: Value) -> some View {
        self
            .modifier(ContextModifier(attribute: attribute, value: value))
    }
    
}

internal struct ContextModifier<Key: Hashable, Value: Hashable>: ViewModifier {
    
    @Environment(\.styleContext) private var context
    @Environment(\.colorScheme) private var colorScheme

    let attribute: SnapStyle.Context.Attribute<Key, Value>
    let value: Value

    func body(content: Content) -> some View {
        let modified = context
            .withAttribute(value: value, for: attribute)
            .withAttribute(value: colorScheme, for: SnapStyle.Context.colorScheme)
        content
            .environment(\.styleContext, modified)
    }
    
}
