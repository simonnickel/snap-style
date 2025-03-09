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
            
            StyleHStack {
                contentCornerView
            }
            .style(component: .card)
            
            ScrollingHStack {
                contentCornerView
                    .style(component: .card)
                contentCornerView
                    .style(component: .card)
                contentCornerView
                    .style(component: .card)
                contentCornerView
                    .style(component: .card)
                contentCornerView
                    .style(component: .card)
            }
            
        }
    }
    
    // TODO: Should this be a specific Component? Like Value/Stats Card.
    private var contentCornerView: some View {
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
                Text("Title")
                    .style(element: .title)
            },
            bottomTrailing: {
                EmptyView()
            }
        )
    }
}


// MARK: - Preview

#Preview {
    ComponentCardScreen()
}
