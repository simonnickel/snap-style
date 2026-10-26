//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

extension View {

    /// Sets the `Font.Design`. Inert value: `nil`, keeps the value from `Context`.
    public func style(fontDesign: Font.Design?) -> some View {
        self
            .style(attribute: Style.Context.fontDesign, value: fontDesign)
    }

}
