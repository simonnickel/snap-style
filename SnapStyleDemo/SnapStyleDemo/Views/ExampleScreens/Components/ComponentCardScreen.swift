//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ComponentCardScreen: View {
    var body: some View {
        StyleScreen {
            
            StyleVStack {
                ElementStackView(axis: .horizontal)
            }
            .style(component: .card)
            
            StyleVStack {
                ElementStackView(axis: .horizontal, hierarchy: .secondary)
            }
            .style(component: .card)
            
            contentCornerValueCard
            
            ScrollingHStack {
                contentCornerValueCard
                contentCornerValueCard
                contentCornerValueCard
                contentCornerValueCard
                contentCornerValueCard
                contentCornerValueCard
            }
            
            contentCardView
                .style(component: .card)
        }
    }
    
    private var contentCardView: some View {
        StyleVStack {
            StructuredTextView()
            StyleHStack {
                // TODO: Should be .secondary, but is not visible. Could be automatically detected to use different accen style.
                StyleButton(.primary) { } content: {
                    Text("Primary")
                        .style(element: .title)
                }
                .style(component: .action)
                StyleSpacer()
                StyleButton(.primary) { } content: {
                    Text("Primary")
                        .style(element: .title)
                }
                .style(component: .action)
            }
        }
    }
    
    private var contentCornerValueCard: some View {
        CornerContainer(
            topLeading: {
                Image(systemName: "star")
                    .style(element: .icon)
            },
            topTrailing: {
                Text("1234")
                    .style(element: .value)
            },
            bottomLeading: {
                StyleVStack {
                    Text("Title")
                        .style(element: .title)
                    Text("Subtitle")
                        .style(element: .title, hierarchy: .secondary)
                }
            },
            bottomTrailing: {
                EmptyView()
            }
        )
        .style(component: .valueCard)
    }
}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
