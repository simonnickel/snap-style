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
    ///
    /// Supports animated change.
    ///
    /// - Parameters:
    ///   - keyPath: The `Number` to apply as padding. `nil` might apply a default value. Set `\.zero` to remove safeArea.
    ///   - edges: The set of edges to pad for this view. The default is `.all`.
    public func style(
        safeAreaPadding keyPath: Style.Keys.NumberKey.ValueBuilderKeyPath?,
        _ edges: Edge.Set = .all
    ) -> some View {
        modifier(SafeAreaPaddingModifier(keyPath: keyPath, edges: edges))
    }

}


// MARK: - Modifier

private struct SafeAreaPaddingModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Keys.NumberKey.ValueBuilderKeyPath?
    let edges: Edge.Set

    func body(content: Content) -> some View {
        let value = style.cgFloat(for: keyPath)
        content
            .safeAreaPadding(edges, value)
    }

}


// MARK: - Preview

#Preview {

    @Previewable @State var isActive: Bool = true

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

        Button {
            withAnimation {
                isActive.toggle()
            }
        } label: {
            Text("Toggle")
        }
    }
    .style(safeAreaPadding: isActive ? \.spacingSections : nil) // nil applies the default, use \.zero to set no safe area.

}
