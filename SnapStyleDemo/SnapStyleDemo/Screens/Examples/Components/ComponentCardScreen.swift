//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {

            Stack(spacing: \.spacingElements) {
                Text("Metric Card")
                    .style(element: .title)
                ScrollingHStack {
                    DemoMetricCard.exampleCircle
                    DemoMetricCard.exampleTriangle
                    DemoMetricCard.exampleRectangle
                    DemoMetricCard.examplePentagon
                }
            }

            Stack(spacing: \.spacingElements) {
                Text("Content Card")
                    .style(element: .title)
                contentCard
                    .style(component: .contentCard)
            }

            Stack(spacing: \.spacingElements) {
                Text("Accent Card")
                    .style(element: .title)
                contentCard
                    .style(component: .accentCard)
            }

            Stack(spacing: \.spacingGroups) {
                Text("Container Relative")
                    .style(element: .title)
                Stack(spacing: \.spacingGroups) {
                    Stack {
                        Text("Automatic")
                            .style(element: .title)
                    }
                    
                    contentCard
                        .style(component: .contentCard)
                }
                .style(component: .contentCard)
                Stack(spacing: \.spacingGroups) {
                    Stack {
                        Text("Manual clip shape")
                            .style(element: .title)
                    }
                    
                    Stack.H(spacing: \.spacingElements) {
                        DemoMetricCard.exampleRectangle
                        DemoMetricCard.exampleTriangle
                        DemoMetricCard.exampleCircle
                    }
                    .style(shape: \.containerRelative, shouldClip: true)
                }
                .style(component: .contentCard)
            }
            
        }
    }
    
    private var contentCard: some View {
        Stack(spacing: \.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
