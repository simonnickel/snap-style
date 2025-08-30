//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase
import SnapStyleDefinitions

extension View {

    public func style(accent: SnapStyle.Accent, for keyPath: SnapStyle.AccentKey.ValueBuilderKeyPath = \.primary) -> some View {
        self
            .accentColor(keyPath == \.primary ? accent.base : nil)
            .styleOverride(accents: [
                keyPath : .base(.definition(.value(accent))),
            ])
    }

}
