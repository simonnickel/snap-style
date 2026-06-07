//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style.ContextWrapper {

    /// Selects `.primary` or `.secondary` based on the context.
    public var accent: Style.Context.Accent {
        let key = context.accent
        return context.accent(for: key) ?? .fallbackPrimary
        
        // TODO: Set context to use .secondary in container stacks where parent has requiresSecondaryAccent == true.
    }

    /// Convenience access to `primary` specifically, in most cases `.accent` should be used.
    public var accentPrimary: Style.Context.Accent {
        context.accent(for: .primary) ?? .fallbackPrimary
    }

    /// Convenience access to `secondary` specifically, in most cases `.accent` should be used.
    public var accentSecondary: Style.Context.Accent {
        context.accent(for: .secondary) ?? .fallbackSecondary
    }

    /// Convenience access to `destructive` accent.
    public var accentDestructive: Style.Context.Accent {
        context.accent(for: .destructive) ?? .fallbackDestructive
    }
    
    /// Convenience access to an accent for a `Key`.
    public func accent(for key: Style.Context.Accent.Key) -> Style.Context.Accent {
        context.accent(for: key) ?? .fallbackPrimary
    }

}
