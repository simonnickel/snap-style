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
                valueCards
            }

            StyleStack(spacing: \.spacingElements) {
                Text("Content Card")
                    .style(element: .title)
                content
                    .style(component: .contentCard)
            }

            StyleStack(spacing: \.spacingElements) {
                Text("Accent Card")
                    .style(element: .title)
                content
                    .style(component: .accentCard)
            }

            StyleStack(spacing: \.spacingGroups) {
                StyleStack {
                    Text("Secondary")
                        .style(element: .title)
                    Text("Cards inside of Card")
                        .style(element: .title, hierarchy: .secondary)
                }
                
                valueCards
                
                content
                    .style(component: .contentCard)
                
                content
                    .style(component: .accentCard)
            }
            .style(component: .contentCard)
            
        }
    }
    
    private var content: some View {
        StyleStack(spacing: \.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }
    
    private var valueCards: some View {
        ScrollingHStack {
            DemoValueCard.exampleRectangle
            DemoValueCard.exampleTriangle
            DemoValueCard.exampleCircle
            DemoValueCard.exampleRectangle
            DemoValueCard.exampleTriangle
            DemoValueCard.exampleCircle
            DemoValueCard.exampleRectangle
            DemoValueCard.exampleTriangle
            DemoValueCard.exampleCircle
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
