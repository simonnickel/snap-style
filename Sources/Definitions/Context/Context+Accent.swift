//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.Context {

    public var accent: SnapStyle.Accent {
        if component.useSecondaryAccent {
            accentSecondary
        } else {
            accentPrimary
        }
    }

}
