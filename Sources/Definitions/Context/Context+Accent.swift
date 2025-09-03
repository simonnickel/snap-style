//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// Needs to be located in `Definitions` target to have access to values in `AccentKey+Definitions`.

extension SnapStyle.Context {

    public var accent: SnapStyle.AccentKey.ValueBuilderKeyPath? { getValue(for: Self.accent) }

    public static var accent: Attribute<String, SnapStyle.AccentKey.ValueBuilderKeyPath> { .init(key: "Accent", valueDefault: nil) }

}


// MARK: - ContextWrapper

extension SnapStyle.ContextWrapper {

    public var accent: SnapStyle.AccentKey.Value.WrappedValue {
        if let accentKeypath = context.accent {
            accent(for: accentKeypath) ?? .fallbackPrimary
        } else {
            accent(for: \.primary) ?? .fallbackPrimary
        }
    }

    public var accentPrimary: SnapStyle.AccentKey.Value.WrappedValue {
        accent(for: \.primary) ?? .fallbackPrimary
    }

}
