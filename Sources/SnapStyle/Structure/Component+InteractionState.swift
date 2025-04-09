//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ComponentDefinition {

    // TODO: Continue
    // - Extend Surface to hold values for ComponentState for foreground and background.
    // - SurfaceBackgroundModifier and SurfaceForgroundModifier have to apply those based on the context.

    public enum InteractionState {
        case disabled
        case normal
        case highlighted
        case selected
    }

}

