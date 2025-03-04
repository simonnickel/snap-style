//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    public func style(foreground keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(ColorForegroundModifier(keyPath: keyPath))
    }
    
    public func style(
        background keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath,
        ignoresSafeAreaEdges: Edge.Set = SnapStyle.SurfaceKey.Value.LayeredShapeStyle.ignoresSafeAreaEdgesDefault
    ) -> some View {
        self
            .modifier(ColorBackgroundModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
    }

}


// MARK: - Modifier

internal struct ColorForegroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let color = style.color(for: keyPath, in: styleContext)
        {
            content
                .foregroundStyle(color)
        } else {
            content
        }
    }

}

internal struct ColorBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.ColorKey.ValueBuilderKeyPath
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        if
            let color = style.color(for: keyPath, in: styleContext)
        {
            content
                .background(color, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}
