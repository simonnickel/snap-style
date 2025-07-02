//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentActionScreen: View {
    var body: some View {
        StyleScreen {

            StyleStack(spacing: \.spacingElements) {
                Text("Content Card - Accent")
                    .style(element: .title)
                ActionButtonsView()
                ActionButtonsView(enabled: false)
            }
            .style(component: .contentCard)
            
            StyleStack(spacing: \.spacingElements) {
                Text("Accent Card - Alternative")
                    .style(element: .title)
                ActionButtonsView()
                ActionButtonsView(enabled: false) // TODO: Disabled on accent.
            }
            .style(component: .accentCard)
            
            StyleStack(spacing: \.spacingElements) {
                Text("Subtitles")
                    .style(element: .title)
                ActionButtonsView(elements: [.secondarySubtitle, .primarySubtitle])
            }
            .style(component: .contentCard)
            
            StyleStack(spacing: \.spacingElements) {
                Text("Icons")
                    .style(element: .title)
                StyleStack(.horizontal) {
                    StyleButton(.icon(hierarchy: .primary)) { } content: {
                        // TODO: Why does StyleLabel not work?
//                        StyleLabel(icon: \.favorite)
                        StyleIcon(\.favorite)
                    }
                    StyleButton(.icon(hierarchy: .secondary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                    StyleButton(.icon(hierarchy: .tertiary)) { } content: {
                        StyleLabel(icon: \.favorite)
                    }
                }
            }
            .style(component: .contentCard)

            StyleButton(.component(.accentCard)) {} content: {
                StructuredTextView(title: "Interactive Accent Card")
            }

        }
    }
}


// MARK: - Preview

#Preview {
    ComponentActionScreen()
}
