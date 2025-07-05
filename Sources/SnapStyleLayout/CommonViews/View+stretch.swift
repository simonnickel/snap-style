//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func stretch(alignment: Alignment = .leading) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }

}
