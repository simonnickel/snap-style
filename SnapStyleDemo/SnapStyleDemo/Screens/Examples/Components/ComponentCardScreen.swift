//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {

            StyleVStack(\.spacingElements) {
                Text("Metric Card")
                    .style(element: .title)
                ScrollingHStack {
                    DemoMetricCard.exampleCircle
                    DemoMetricCard.exampleTriangle
                    DemoMetricCard.exampleRectangle
                    DemoMetricCard.examplePentagon
                }
            }

            StyleVStack(\.spacingElements) {
                Text("Content Card")
                    .style(element: .title)
                contentCard
                    .style(component: .contentCard)
            }

            StyleVStack(\.spacingElements) {
                Text("Accent Card")
                    .style(element: .title)
                contentCard
                    .style(component: .accentCard)
            }

            StyleVStack(\.spacingGroups) {
                Text("Container Relative")
                    .style(element: .title)
                StyleVStack(\.spacingGroups) {
                    StyleVStack {
                        Text("Automatic")
                            .style(element: .title)
                    }
                    
                    contentCard
                        .style(component: .contentCard)
                }
                .style(component: .contentCard)
                StyleVStack(\.spacingGroups) {
                    StyleVStack {
                        Text("Manual clip shape")
                            .style(element: .title)
                    }
                    
                    StyleHStack(\.spacingElements) {
                        DemoMetricCard.exampleRectangle
                        DemoMetricCard.exampleTriangle
                        DemoMetricCard.exampleCircle
                    }
                    .style(shape: \.containerRelative)
                }
                .style(component: .contentCard)
            }
            
        }
    }
    
    private var contentCard: some View {
        StyleVStack(\.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
