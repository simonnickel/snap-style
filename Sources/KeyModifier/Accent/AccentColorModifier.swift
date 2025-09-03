//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions


// MARK: - Modifier

extension View {

    public func style(accent: SnapStyle.AccentKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(AccentColorModifier(keyPath: accent))
            .style(attribute: SnapStyle.Context.accent, value: accent)
    }

}


// MARK: - Modifier

private struct AccentColorModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.AccentKey.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        if
            let keyPath,
            keyPath == \.primary,
            let definition = style.accent(for: keyPath),
            let color = style.surface(for: definition.base)
        {
            content
                .accentColor(color.resolvedColor)
        } else {
            content
        }
    }

}
