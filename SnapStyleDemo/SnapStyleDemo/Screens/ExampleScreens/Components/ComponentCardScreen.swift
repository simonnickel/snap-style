//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {

            DemoValueCard.exampleRectangle

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

            contentCardView
                .style(component: .accentCard)
        }
    }

    private var contentCardView: some View {
        StyleVStack(spacing: \.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }
    
}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
