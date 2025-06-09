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
            
            ComponentContainer(title: "Icon", component: .content) {
                StyleHStack(spacing: \.spacingGroups) {
                    StyleButton(.icon(hierarchy: .primary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                    StyleButton(.icon(hierarchy: .secondary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                    StyleButton(.icon(hierarchy: .tertiary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                }
            }

        }
    }
}


// MARK: - Preview

#Preview {
    ComponentActionScreen()
}
