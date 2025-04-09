//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.Component {

    // - Extend Surface to hold values for ComponentState for foreground and background.
    // - SurfaceBackgroundModifier and SurfaceForgroundModifier have to apply those based on the context.
    // - Remove context.isHighlighted

    public enum InteractionState {
        case disabled
        case normal
        case highlighted
        case selected
    }

}

