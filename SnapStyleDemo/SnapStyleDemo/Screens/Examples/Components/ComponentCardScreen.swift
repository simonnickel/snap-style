//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {

            StackV(\.spacingElements) {
                Text("Metric Card")
                    .style(element: .title)
                ScrollingHStack {
                    DemoMetricCard.exampleCircle
                    DemoMetricCard.exampleTriangle
                    DemoMetricCard.exampleRectangle
                    DemoMetricCard.examplePentagon
                }
            }

            StackV(\.spacingElements) {
                Text("Content Card")
                    .style(element: .title)
                contentCard
                    .style(component: .contentCard)
            }

            StackV(\.spacingElements) {
                Text("Accent Card")
                    .style(element: .title)
                contentCard
                    .style(component: .accentCard)
            }

            StackV(\.spacingGroups) {
                Text("Container Relative")
                    .style(element: .title)
                StackV(\.spacingGroups) {
                    StackV {
                        Text("Automatic")
                            .style(element: .title)
                    }
                    
                    contentCard
                        .style(component: .contentCard)
                }
                .style(component: .contentCard)
                StackV(\.spacingGroups) {
                    StackV {
                        Text("Manual clip shape")
                            .style(element: .title)
                    }
                    
                    StackH(\.spacingElements) {
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
        StackV(\.spacingGroups) {
            StructuredTextView()
            ActionButtonsView()
        }
    }

}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
