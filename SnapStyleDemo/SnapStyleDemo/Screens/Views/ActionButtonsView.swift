//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ActionButtonsView: View {

    enum Element {
        case secondarySubtitle, primarySubtitle
    }

    let elements: [Element]
    let isEnabled: Bool

    internal init(elements: [Element] = [], enabled: Bool = true) {
        self.elements = elements
        self.isEnabled = enabled
    }

    var body: some View {
        StyleStack(.horizontal) {
            StyleButton(.secondary, enabled: isEnabled) { } content: {
                StyleStack(isStretching: false) {
                    Text("Secondary")
                        .style(element: .action)
                    if elements.contains(.secondarySubtitle) {
                        Text("Subtitle")
                            .style(element: .action, hierarchy: .secondary)
                    }
                }
            }
            
            StyleSpacer()
            
            StyleButton(.primary, enabled: isEnabled) { } content: {
                StyleStack(isStretching: false) {
                    Text("Primary")
                        .style(element: .action)
                    if elements.contains(.primarySubtitle) {
                        Text("Subtitle")
                            .style(element: .action, hierarchy: .secondary)
                    }
                }
            }
        }
    }
}


// MARK: - Preview

#Preview {
    ActionButtonsView()
}
