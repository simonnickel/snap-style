//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    /// Adds the provided insets into the safe area of this view.
    /// Content behaves differently:
    /// - background by default extends behind safe area.
    /// - ScrollView uses safe area to align content, but scrolls behind it.
    ///
    /// Use `.ignoresSafeArea(.container, edges: .horizontal)` or `.background(Color, ignoresSafeAreaEdges: .vertical)` to modify behaviour.
    public func style(safeAreaPadding keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath, _ edges: Edge.Set = .all) -> some View {
        self
            .modifier(SafeAreaPaddingModifier(keyPath: keyPath, edges: edges))
    }

}


// MARK: - Modifier

internal struct SafeAreaPaddingModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        if
            let padding = style.number(for: keyPath, in: styleContext)
        {
            content
                .safeAreaPadding(edges, padding)
        } else {
            content
        }
    }
    
}


// MARK: - Preview

#Preview {
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
    .style(safeAreaPadding: \.paddingScreenHorizontal)
}
