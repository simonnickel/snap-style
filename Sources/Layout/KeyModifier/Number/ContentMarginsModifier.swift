//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    /// Set the content margins of this view.
    public func style(
        contentMargins keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath,
        _ edges: Edge.Set = .all,
        placement: ContentMarginPlacement = .automatic
    ) -> some View {
        modifier(ContentMarginModifier(keyPath: keyPath, edges: edges, placement: placement))
    }

}


// MARK: - Modifier

internal struct ContentMarginModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    let edges: Edge.Set
    let placement: ContentMarginPlacement
    
    func body(content: Content) -> some View {
        if
            let value = style.number(for: keyPath)
        {
            content
                .contentMargins(edges, value, for: placement)
        } else {
            content
        }
    }
    
}


// MARK: - Preview

#Preview {
    ScrollView {
        VStack {
            // Default placement inside of safe area
            Rectangle()
            
            // Ignore safe area
            Rectangle()
                .ignoresSafeArea(.container, edges: .horizontal)
            
            // Background has to handle safe area.
            VStack {
                Text("Background ignores safe area by default!")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.green)
            VStack {
                Text("Needs to be handled manually.")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.green, ignoresSafeAreaEdges: .vertical)
            
            // Scroll view automatic behaviour.
            ScrollView(.horizontal) {
                LazyHStack {
                    Text("ScrollView automatically allows to scroll behind safe area!")
                }
                .background(.green)
            }
        }
    }
    .style(contentMargins: \.paddingScreenHorizontal, .all, placement: .automatic)
}
