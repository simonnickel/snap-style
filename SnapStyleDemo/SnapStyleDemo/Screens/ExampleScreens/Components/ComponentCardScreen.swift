//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {
            
            valueCards

            content
                .style(component: .contentCard)
            
            content
                .style(component: .accentCard)
            
            StyleVStack(spacing: \.spacingGroups) {
                StyleVStack {
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
        StyleVStack(spacing: \.spacingGroups) {
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
