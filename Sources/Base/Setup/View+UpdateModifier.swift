//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    /// Update the `SnapStyle` definition in the Environment.
    public func style(update definition: Style) -> some View {
        modifier(UpdateDefinitionModifier(definition: definition))
    }

    /// Update the `Context` in the Environment.
    package func style(update context: Style.Context) -> some View {
        modifier(UpdateContextModifier(context: context))
    }

}

internal struct UpdateDefinitionModifier: ViewModifier {

    @Environment(\.style) private var style

    let definition: Style

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.updated(with: definition))
    }

}

internal struct UpdateContextModifier: ViewModifier {

    @Environment(\.style) private var style

    let context: Style.Context

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.updated(with: context))
    }

}
