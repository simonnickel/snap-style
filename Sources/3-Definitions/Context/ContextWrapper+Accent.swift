//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style.ContextWrapper {

    public var accent: Style.Context.Accent {
        if context.containerStack.parent?.requiresSecondaryAccent ?? false {
            return accentSecondary
        }
        return accentPrimary
    }

    public var accentPrimary: Style.Context.Accent {
        context.accentPrimary ?? .fallbackPrimary
    }

    public var accentSecondary: Style.Context.Accent {
        context.accentSecondary ?? .fallbackSecondary
    }

}
