//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    /// Setup the view hierarchy and `Context` to use the styling.
    public func styleSetup(_ definition: Style) -> some View {
        modifier(SetupModifier())
            .style(update: definition)
    }

}

internal struct SetupModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: colorScheme, for: Style.Context.colorScheme)
        content
            .style(update: context)
    }

}
