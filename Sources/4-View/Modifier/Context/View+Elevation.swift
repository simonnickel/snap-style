//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

// Elevation is provided from outside via the Environment.
// Use `styleElevationRelay()` to forward the environment value into the `Context`.
extension View {
    
    /// Elevation is provided from outside of SnapStyle via the Environment (`\.styleElevation`) and has to be forwarded into the `Context`.
    public func styleElevationRelay() -> some View {
        self
            .modifier(ElevationRelayModifier())
    }
    
}

private struct ElevationRelayModifier: ViewModifier {
    
    @Environment(\.styleElevation) private var elevation
    
    func body(content: Content) -> some View {
        content
            .style(attribute: Style.Context.elevation, value: elevation)
    }
    
}
