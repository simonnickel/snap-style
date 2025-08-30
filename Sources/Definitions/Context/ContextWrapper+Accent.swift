//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ContextWrapper {

    public var accent: SnapStyle.AccentKey.Value.WrappedValue {
        if context.component.useSecondaryAccent {
            accent(for: \.secondary) ?? .fallbackSecondary
        } else {
            accent(for: \.primary) ?? .fallbackPrimary
        }
    }
    
    public var accentPrimary: SnapStyle.AccentKey.Value.WrappedValue {
        accent(for: \.primary) ?? .fallbackPrimary
    }

}
