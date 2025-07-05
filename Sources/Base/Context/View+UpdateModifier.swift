//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    /// Update the `SnapStyle` definition in the Environment.
    public func style(update definition: SnapStyle) -> some View {
        modifier(UpdateDefinitionModifier(definition: definition))
    }

    /// Update the `Context` in the Environment.
    package func style(update context: SnapStyle.Context) -> some View {
        modifier(UpdateContextModifier(context: context))
    }

}

internal struct UpdateDefinitionModifier: ViewModifier {

    @Environment(\.style) private var style

    let definition: SnapStyle

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.update(definition: definition))
    }

}

internal struct UpdateContextModifier: ViewModifier {

    @Environment(\.style) private var style

    let context: SnapStyle.Context

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.update(context: context))
    }

}
