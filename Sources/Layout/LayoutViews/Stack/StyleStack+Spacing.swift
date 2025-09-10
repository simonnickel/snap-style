//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(spacing keyPath: Style.NumberKey.ValueBuilderKeyPath?) -> some View {
        modifier(StackSpacingModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct StackSpacingModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.NumberKey.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        content
            .environment(\.styleStackSpacing, keyPath)
    }

}


// MARK: - Environment

extension EnvironmentValues {

    @Entry package var styleStackSpacing: Style.NumberKey.ValueBuilderKeyPath? = nil

}
