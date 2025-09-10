//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions


// MARK: - Modifier

extension View {

    public func style(accent: Style.AccentKey.ValueBuilderKeyPath?) -> some View {
        self
            .modifier(AccentColorModifier(keyPath: accent))
    }

}


// MARK: - Modifier

private struct AccentColorModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.AccentKey.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        if
            let keyPath,
            let definition = style.accent(for: keyPath),
            let color = style.surface(for: definition.base)
        {
            content
                .accentColor(keyPath == \.primary ? color.resolvedColor : nil)
                .style(attribute: Style.Context.accent, value: keyPath)
        } else {
            content
        }
    }

}
