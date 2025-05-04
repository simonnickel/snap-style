//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    /// Setup the view hierarchy and `Context` to use the styling.
    public func style(setup definition: SnapStyle) -> some View {
        self
            .modifier(SetupModifier())
            .style(update: definition)
    }
    
}

internal struct SetupModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: colorScheme, for: SnapStyle.Context.colorScheme)
        content
            .style(update: context)
    }
    
}
