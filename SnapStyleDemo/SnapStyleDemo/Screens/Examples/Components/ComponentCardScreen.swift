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
                Text("Metric Card")
                    .style(element: .title)
                ScrollingHStack {
                    DemoMetricCard.exampleCircle
                    DemoMetricCard.exampleTriangle
                    DemoMetricCard.exampleRectangle
                    DemoMetricCard.examplePentagon
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

            StyleStack(spacing: \.spacingGroups) {
                Text("Container Relative")
                    .style(element: .title)
                StyleStack(spacing: \.spacingGroups) {
                    StyleStack {
                        Text("Automatic")
                            .style(element: .title)
                    }
                    
                    contentCard
                        .style(component: .contentCard)
                }
                .style(component: .contentCard)
                StyleStack(spacing: \.spacingGroups) {
                    StyleStack {
                        Text("Manual clip shape")
                            .style(element: .title)
                    }
                    
                    StyleStack(.horizontal, spacing: \.spacingElements) {
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
