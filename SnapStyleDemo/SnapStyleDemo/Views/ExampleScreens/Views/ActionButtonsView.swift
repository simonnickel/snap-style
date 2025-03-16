//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ActionButtonsView: View {
    var body: some View {
        StyleHStack {
            StyleButton(.secondary) { } content: {
                Text("Secondary")
                    .style(element: .title)
            }
            
            StyleSpacer()
            
            StyleButton(.primary) { } content: {
                StyleVStack(isStretching: false) {
                    Text("Primary")
                        .style(element: .title)
                    Text("Subtitle")
                        .style(element: .title, hierarchy: .secondary)
                }
            }
        }
    }
}
