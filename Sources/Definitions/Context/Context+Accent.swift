//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// TODO: Move all Context Values from base to Definitions?
// Needs to be located in `Definitions` target to have access to values in `AccentKey+Definitions`.

extension SnapStyle.Context {

    public var accent: SnapStyle.AccentKey.ValueBuilderKeyPath? { getValue(for: Self.accent) }

    public static var accent: Attribute<String, SnapStyle.AccentKey.ValueBuilderKeyPath> { .init(key: "Accent", valueDefault: nil) }

}


// MARK: - ContextWrapper

extension SnapStyle.ContextWrapper {

    public var accent: SnapStyle.AccentKey.Value.WrappedValue {
        // TODO: Can I get rid of `useSecondaryAccent` and just set the context?
        if context.component.useSecondaryAccent {
            accent(for: \.secondary) ?? .fallbackSecondary
        } else {
            if let accentKeypath = context.accent {
                accent(for: accentKeypath) ?? .fallbackPrimary
            } else {
                accent(for: \.primary) ?? .fallbackPrimary
            }
        }
    }

    public var accentPrimary: SnapStyle.AccentKey.Value.WrappedValue {
        accent(for: \.primary) ?? .fallbackPrimary
    }

}
