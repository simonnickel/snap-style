//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

extension View {

    // TODO: Needs inert value
    /// Sets the `Font.Width`.
    public func style(fontWidth: Font.Width) -> some View {
        self
            .style(attribute: Style.Context.fontWidth, value: fontWidth)
    }

}
