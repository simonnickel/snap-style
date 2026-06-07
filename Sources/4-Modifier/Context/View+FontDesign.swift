//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

extension View {

    // TODO: Needs inert value
    /// Sets the `Font.Design`.
    public func style(fontDesign: Font.Design = Style.Context.fontDesignDefault) -> some View {
        self
            .style(attribute: Style.Context.fontDesign, value: fontDesign)
    }

}
