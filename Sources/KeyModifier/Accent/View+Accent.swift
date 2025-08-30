//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions

extension View {

    public func style(accent: SnapStyle.AccentKey.Value.WrappedValue, for keyPath: SnapStyle.AccentKey.ValueBuilderKeyPath = \.primary) -> some View {
        self
            .modifier(AccentColorModifier(keyPath: keyPath))
            .styleOverride(accents: [
                keyPath : .base(.definition(.value(accent))),
            ])
    }

}


// MARK: - Modifier

private struct AccentColorModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.AccentKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
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
