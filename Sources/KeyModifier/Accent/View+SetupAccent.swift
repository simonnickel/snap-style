//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions

extension View {

    public func styleSetup(
        accent: SnapStyle.AccentKey.Value.WrappedValue,
        for keyPath: SnapStyle.AccentKey.ValueBuilderKeyPath = \.primary
    ) -> some View {
        self
            .styleSetup(accents: [keyPath: accent])
    }

    public func styleSetup(
        accents: [SnapStyle.AccentKey.ValueBuilderKeyPath : SnapStyle.AccentKey.Value.WrappedValue]
    ) -> some View {
        self
            .modifier(AccentColorModifier(keyPath: accents.keys.first { $0 == \.primary }))
            .styleOverride(accents: accents.mapValues { .base(.definition(.value($0))) })
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
