//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct StructuredScreen: View {

    var body: some View {
        StyleScreen {
            contentCardRow

            content
                .style(component: .contentCard)

            content
                .style(component: .contentCard)
        }
        .navigationTitle("Structured")
    }

    @ViewBuilder
    private var contentCardRow: some View {
        ScrollingHStack {
            DemoMetricCard.exampleRectangle
            DemoMetricCard.exampleTriangle
            DemoMetricCard.exampleCircle
            DemoMetricCard.exampleRectangle
            DemoMetricCard.exampleTriangle
            DemoMetricCard.exampleCircle
            DemoMetricCard.exampleRectangle
            DemoMetricCard.exampleTriangle
            DemoMetricCard.exampleCircle
        }
    }

    @ViewBuilder
    private var content: some View {
        StyleStack(spacing: \.spacingSections) {
            contentCards
            StructuredTextView()
            ActionButtonsView()
        }
    }

    @ViewBuilder
    private var contentCards: some View {
        StyleStack(.horizontal, spacing: \.spacingElements) {
            DemoMetricCard.exampleRectangle
            DemoMetricCard.exampleTriangle
        }
    }

}

#Preview {
    NavigationStack {
        StructuredScreen()
//            .styleOverride(
//                surfaces: [
//                    \.onAccent: SnapStyle.ValueBuilder.builder { context in
//                        .definition(.color(.yellow))
//                    }
//                ]
//            )
    }
}
