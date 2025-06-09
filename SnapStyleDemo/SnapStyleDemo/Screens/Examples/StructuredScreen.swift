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
            contentCard
            contentCard
            contentCard
            contentCard
            contentCard
            contentCard
            contentCard
        }
    }

    @ViewBuilder
    private var content: some View {
        StyleVStack(spacing: \.spacingSections) {
            contentCards
            StructuredTextView()
            contentButtons
        }
    }

    @ViewBuilder
    private var contentCards: some View {
        StyleHStack(spacing: \.spacingElements) {
            contentCard
            contentCard
        }
    }

    @ViewBuilder
    private var contentCard: some View {
        CornerContainer {
            Image(systemName: "triangle")
                .style(element: .icon)
        } topTrailing: {
            Text("Value")
                .style(element: .value)
        } bottomLeading: {
            Text("Title")
                .style(element: .title, hierarchy: .primary)
        } bottomTrailing: {
            
        }
        .style(component: .valueCard)
    }

    @ViewBuilder
    private var contentButtons: some View {
        StyleHStack {
            StyleButton {
            } content: {
                Label("Action", systemImage: "star")
            }

            Spacer()

            StyleButton {
            } content: {
                Label("Action", systemImage: "star")
            }
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
