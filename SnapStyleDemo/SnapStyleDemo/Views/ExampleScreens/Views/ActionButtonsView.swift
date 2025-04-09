//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct ActionButtonsView: View {

    enum Element {
        case secondarySubtitle, primarySubtitle
    }

    let elements: [Element]
    let state: SnapStyle.Component.InteractionState

    internal init(elements: [Element] = [], state: SnapStyle.Component.InteractionState = .normal) {
        self.elements = elements
        self.state = state
    }

    var body: some View {
        StyleHStack {
            StyleButton(.secondary, state: state) { } content: {
                StyleVStack(isStretching: false) {
                    Text("Secondary")
                        .style(element: .action)
                    if elements.contains(.secondarySubtitle) {
                        Text("Subtitle")
                            .style(element: .action, hierarchy: .secondary)
                    }
                }
            }
            
            StyleSpacer()
            
            StyleButton(.primary, state: state) { } content: {
                StyleVStack(isStretching: false) {
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
