//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SnapStyleBase
import SwiftUI

struct StructuredScreen: View {

    var body: some View {
        StyleScreen {
            contentCardRow

            content
                .style(component: .content)

            content
                .style(component: .content)
        }
        .navigationTitle("Structured")
    }

    @ViewBuilder
    private var contentCardRow: some View {
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

    @ViewBuilder
    private var content: some View {
        StyleVStack(spacing: \.spacingSections) {
            contentCards
            StructuredTextView()
            ActionButtonsView()
        }
    }

    @ViewBuilder
    private var contentCards: some View {
        StyleHStack(spacing: \.spacingElements) {
            DemoValueCard.exampleRectangle
            DemoValueCard.exampleTriangle
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
