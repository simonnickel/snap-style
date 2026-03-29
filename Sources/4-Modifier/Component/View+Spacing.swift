//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    /// Define the spacing that should be used inside.
    public func style(spacing keyPath: Style.Attribute.Number.ValueBuilderKeyPath?) -> some View {
        modifier(SpacingModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct SpacingModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Attribute.Number.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        content
            .environment(\.styleSpacing, keyPath)
    }

}


// MARK: - Environment

extension EnvironmentValues {

    @Entry package var styleSpacing: Style.Attribute.Number.ValueBuilderKeyPath? = nil

}
