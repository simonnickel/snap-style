//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    public func style(
        background keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath,
        ignoresSafeAreaEdges: Edge.Set = []
    ) -> some View {
        self
            .modifier(SurfaceBackgroundModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
    }

}


// MARK: - Modifier

internal struct SurfaceBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        // Background has to be applied if a key is available. Even if no value is present, to allow animation of appearing value.
        let surface = style.surface(for: keyPath)
        content
            .background(surface ?? AnyShapeStyle(.clear), ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}


// MARK: - Preview

#Preview {
    
    Text("Preview Example View")
        .padding()
        .style(background: \.accent)
    
}
