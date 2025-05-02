//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    /// Set value of a `Context` attribute for use in Environment.
    public func styleBase() -> some View {
        self
            .modifier(BaseModifier())
    }
    
}

internal struct BaseModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: colorScheme, for: SnapStyle.Context.colorScheme)
        content
            .tint(context.accent.base)
            .style(update: context)
    }
    
}
