//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

// Needs to be located in `Definitions` target to have access to values in `Accent+Definitions`.

extension Style.Context {

    public var accentPrimary: Style.Context.Accent? { getValue(for: Self.accentPrimary) }

    public static var accentPrimary: Attribute<String, Style.Context.Accent> { .init(key: "accentPrimary", valueDefault: nil) }
    
    public var accentSecondary: Style.Context.Accent? { getValue(for: Self.accentSecondary) }

    public static var accentSecondary: Attribute<String, Style.Context.Accent> { .init(key: "accentSecondary", valueDefault: nil) }

}


// MARK: - ContextWrapper

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
