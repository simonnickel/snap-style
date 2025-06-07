//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentActionScreen: View {
    var body: some View {
        StyleScreen {

            ComponentContainer(title: "Content", component: .content) {
                ActionButtonsView()
            }

            ComponentContainer(title: "Content", component: .card) {
                ActionButtonsView()
            }

            ComponentContainer(title: "Disabled", component: .content) {
                ActionButtonsView(enabled: false)
            }

            ComponentContainer(title: "Subtitles", component: .content) {
                ActionButtonsView(elements: [.secondarySubtitle, .primarySubtitle])
            }


            // MARK: Elements

            StyleVStack(spacing: \.spacingElements) {
                Text("Elements")
                    .style(element: .title, hierarchy: .secondary)

                StyleVStack(isStretching: false) {
                    ElementStackView(axis: .horizontal)
                }
                .style(component: .action)

                StyleVStack(isStretching: false) {
                    ElementStackView(axis: .horizontal, hierarchy: .secondary)
                }
                .style(component: .action)
            }

        }
    }
}


// MARK: - Preview

#Preview {
    ComponentActionScreen()
}
