//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// Needs to be located in `Definitions` target to have access to values in `Accent+Definitions`.

extension Style.Context {

    public var accent: Style.Attribute.Accent.Value.WrappedValue? { getValue(for: Self.accent) }

    public static var accent: Attribute<String, Style.Attribute.Accent.Value.WrappedValue> { .init(key: "accent", valueDefault: nil) }

}


// MARK: - ContextWrapper

extension Style.ContextWrapper {

    public var accent: Style.Attribute.Accent.Value.WrappedValue {
        context.accent ?? accentPrimary
    }

    public var accentPrimary: Style.Attribute.Accent.Value.WrappedValue {
        accent(for: \.primary) ?? .fallbackPrimary
    }

}
