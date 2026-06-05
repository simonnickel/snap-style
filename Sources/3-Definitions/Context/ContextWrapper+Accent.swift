//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style.ContextWrapper {

    /// Selects `.primary` or `.secondary` based on the context.
    public var accent: Style.Context.Accent {
        if context.containerStack.parent?.requiresSecondaryAccent ?? false {
            return accentSecondary
        }
        return accentPrimary
    }

    /// Convenience access to `primary` specifically, in most cases `.accent` should be used.
    public var accentPrimary: Style.Context.Accent {
        context.accent(.primary) ?? .fallbackPrimary
    }

    /// Convenience access to `secondary` specifically, in most cases `.accent` should be used.
    public var accentSecondary: Style.Context.Accent {
        context.accent(.secondary) ?? .fallbackSecondary
    }

    /// Convenience access to `destructive` accent.
    public var accentDestructive: Style.Context.Accent {
        context.accent(.destructive) ?? .fallbackDestructive
    }

}
