//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

extension View {

    /// Sets the `Font.Width`. Inert value: `nil`, keeps the value from `Context`.
    public func style(fontWidth: Font.Width?) -> some View {
        self
            .style(attribute: Style.Context.fontWidth, value: fontWidth)
    }

}
