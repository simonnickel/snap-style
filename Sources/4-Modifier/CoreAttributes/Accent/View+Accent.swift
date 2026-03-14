//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions


// MARK: - Modifier

extension View {

    public func style(accent: Style.Attribute.Accent.ValueBuilderKeyPath?) -> some View {
        self
            .modifier(AccentColorModifier(keyPath: accent))
    }

}


// MARK: - Modifier

private struct AccentColorModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Accent.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        if
            let keyPath,
            let definition = style.accent(for: keyPath),
            let color = style.surface(for: definition.base)
        {
            content
            // TODO: .accentColor() is deprecated, but I think this is used in the definitions to get the system defined tint color. Need to check and replace. Also check other uses of .accentColor.
                .accentColor(keyPath == \.primary ? color.resolvedColor : nil)
                .tint(keyPath == \.primary ? color.resolvedColor : nil)
                .style(attribute: Style.Context.accent, value: keyPath)
        } else {
            content
        }
    }

}
