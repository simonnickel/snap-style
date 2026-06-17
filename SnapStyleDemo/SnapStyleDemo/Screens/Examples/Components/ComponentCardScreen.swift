//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {

            StackV(spacing: \.spacingElements) {
                Text("Metric Card")
                    .style(element: .title)
                ScrollingHStack {
                    DemoMetricCard.exampleCircle
                    DemoMetricCard.exampleTriangle
                    DemoMetricCard.exampleRectangle
                    DemoMetricCard.examplePentagon
                }
            }

            StackV(spacing: \.spacingElements) {
                Text("Content Card")
                    .style(element: .title)
                contentCard
                    .style(component: .contentCard)
            }

            StackV(spacing: \.spacingElements) {
                Text("Accent Card")
                    .style(element: .title)
                contentCard
                    .style(component: .accentCard)
            }

            StackV(spacing: \.spacingGroups) {
                Text("Container Relative")
                    .style(element: .title)
                StackV(spacing: \.spacingGroups) {
                    StackV {
                        Text("Automatic")
                            .style(element: .title)
                    }
                    
                    contentCard
                        .style(component: .contentCard)
                }
                .style(component: .contentCard)
                StackV(spacing: \.spacingGroups) {
                    StackV {
                        Text("Manual clip shape")
                            .style(element: .title)
                    }
                    
                    StackH(spacing: \.spacingElements) {
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
        StackV(spacing: \.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
