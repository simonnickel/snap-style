//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    /// Set up the view hierarchy and `Context` to use the styling.
    /// ```
    /// @State var style: Style = Style()
    ///
    /// var body: some View {
    ///     Content()
    ///         .styleSetup(style)
    /// }
    /// ```
    public func styleSetup(_ definition: Style) -> some View {
        modifier(SetupModifier())
            .style(update: definition)
    }
    
    #if DEBUG
    /// Convenience definition to allow a setup without a dedicated `Style` instance, e.g. for Previews.
    /// The container is re-instantiated on body evaluations.
    public func styleSetupLazy() -> some View {
        self.styleSetup(Style())
    }
    #endif

}

private struct SetupModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.colorScheme) private var colorScheme
    
    @ScaledMetric private var dynamicTypeScale: Double = 1

    func body(content: Content) -> some View {
        let context = style.context
            .withAttribute(value: colorScheme, for: Style.Context.colorScheme)
            .withAttribute(value: dynamicTypeScale, for: Style.Context.scaleDynamicType)
        content
            .style(update: context)
    }

}
