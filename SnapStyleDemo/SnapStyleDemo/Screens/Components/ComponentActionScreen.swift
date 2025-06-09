//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentActionScreen: View {
    var body: some View {
        StyleScreen {

            ComponentContainer(title: "Content Card", component: .contentCard) {
                ActionButtonsView()
                ActionButtonsView(enabled: false)
            }

            ComponentContainer(title: "Accent Card", component: .accentCard) {
                ActionButtonsView()
                ActionButtonsView(enabled: false) // TODO: Disabled on accent.
            }

            ComponentContainer(title: "Subtitles", component: .contentCard) {
                ActionButtonsView(elements: [.secondarySubtitle, .primarySubtitle])
            }
            
            ComponentContainer(title: "Icon", component: .contentCard) {
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
