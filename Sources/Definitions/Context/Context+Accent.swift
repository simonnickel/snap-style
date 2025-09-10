//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// Needs to be located in `Definitions` target to have access to values in `AccentKey+Definitions`.

extension Style.Context {

    public var accent: Style.Keys.AccentKey.ValueBuilderKeyPath? { getValue(for: Self.accent) }

    public static var accent: Attribute<String, Style.Keys.AccentKey.ValueBuilderKeyPath> { .init(key: "Accent", valueDefault: nil) }

}


// MARK: - ContextWrapper

extension Style.ContextWrapper {

    public var accent: Style.Keys.AccentKey.Value.WrappedValue {
        if let accentKeypath = context.accent {
            accent(for: accentKeypath) ?? .fallbackPrimary
        } else {
            accent(for: \.primary) ?? .fallbackPrimary
        }
    }

    public var accentPrimary: Style.Keys.AccentKey.Value.WrappedValue {
        accent(for: \.primary) ?? .fallbackPrimary
    }

}
