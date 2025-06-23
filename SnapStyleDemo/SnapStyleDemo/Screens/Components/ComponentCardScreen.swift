//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {

            StyleStack(spacing: \.spacingElements) {
                Text("Value Card")
                    .style(element: .title)
                StyleStack(.horizontal, spacing: \.spacingElements) {
                    DemoValueCard.exampleRectangle
                    DemoValueCard.exampleTriangle
                    DemoValueCard.exampleCircle
                }
            }

            StyleStack(spacing: \.spacingElements) {
                Text("Content Card")
                    .style(element: .title)
                contentCard
                    .style(component: .contentCard)
            }

            StyleStack(spacing: \.spacingElements) {
                Text("Accent Card")
                    .style(element: .title)
                contentCard
                    .style(component: .accentCard)
            }

            StyleStack(spacing: \.spacingGroups, ) {
                StyleStack {
                    Text("Secondary")
                        .style(element: .title)
                    Text("Cards inside of Card")
                        .style(element: .title, hierarchy: .secondary)
                }
                
                StyleStack(.horizontal, spacing: \.spacingElements) {
                    DemoValueCard.exampleRectangle
                    DemoValueCard.exampleTriangle
                    DemoValueCard.exampleCircle
                }
                
                contentCard
                    .style(component: .contentCard)
                
                contentCard
                    .style(component: .accentCard)
            }
            .style(component: .contentCard)
            
        }
    }
    
    private var contentCard: some View {
        StyleStack(spacing: \.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
