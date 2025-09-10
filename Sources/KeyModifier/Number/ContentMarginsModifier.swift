//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    /// Applies the `Number` as `.contentMargin()`
    /// 
    /// Supports animated change.
    /// 
    /// - Parameters:
    ///   - keyPath: The `Number` to apply as length, `nil` will apply no inset.
    ///   - edges: The edges to add the margins to.
    ///   - placement: Where the margins should be added.
    public func style(
        contentMargins keyPath: Style.Keys.Number.ValueBuilderKeyPath?,
        _ edges: Edge.Set = .all,
        placement: ContentMarginPlacement = .automatic
    ) -> some View {
        modifier(ContentMarginModifier(keyPath: keyPath, edges: edges, placement: placement))
    }

}


// MARK: - Modifier

private struct ContentMarginModifier: ViewModifier {

    @Environment(\.style) private var style
    
    let keyPath: Style.Keys.Number.ValueBuilderKeyPath?
    let edges: Edge.Set
    let placement: ContentMarginPlacement
    
    func body(content: Content) -> some View {
        let value = style.cgFloat(for: keyPath)
        content
            .contentMargins(edges, value, for: placement)
    }
    
}


// MARK: - Preview

#Preview {

    @Previewable @State var isActive: Bool = true

    VStack {
        ScrollView {
            VStack {
                Rectangle()

                VStack {
                    Text("Background respects the content margin by default!")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.green)
            }
        }
        .style(contentMargins: isActive ? \.spacingSections : nil, .all, placement: .automatic)

        ScrollView(.horizontal) {
            LazyHStack {
                Text("Applied on ScrollView: Insets the content, but in scroll direction content is visible when scrolling outside!")
            }
        }
        .style(contentMargins: isActive ? \.spacingSections : nil, .all, placement: .automatic)

        Spacer()
    }

    Button {
        withAnimation {
            isActive.toggle()
        }
    } label: {
        Text("Toggle")
    }
}
