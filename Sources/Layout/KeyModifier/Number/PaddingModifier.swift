//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    /// Applies the `Number` as `.padding()`
    ///
    /// Supports animated change.
    ///
    /// - Parameters:
    ///   - keyPath: The `Number` to apply as length of the padding, `nil` is the inert value
    ///   - edges: The set of edges to pad for this view. The default is `.all`.
    public func style(
        padding keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath?,
        _ edges: Edge.Set = .all
    ) -> some View {
        modifier(PaddingModifier(keyPath: keyPath, edges: edges))
    }

}


// MARK: - Modifier

private struct PaddingModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath?
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        let value = style.cgFloat(for: keyPath)
        content
            .padding(edges, value)
    }
    
}


// MARK: - Preview

#Preview {

    @Previewable @State var isActive: Bool = true

    Text("Some Preview Content")
        .style(padding: isActive ? \.spacingSections : nil)
        .background(.green)

    StyleButton {
        withAnimation {
            isActive.toggle()
        }
    } content: {
        Text("Toggle")
    }

}
