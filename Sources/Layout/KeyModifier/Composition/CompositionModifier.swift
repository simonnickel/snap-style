//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(
        composition keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath,
        layers: [SnapStyle.CompositionKey.Layer] = SnapStyle.CompositionKey.Layer.allCases,
        ignoreSafeAreaEdges: Edge.Set = []
    ) -> some View {
        modifier(CompositionModifier(keyPath: keyPath, layers: layers, ignoresSafeAreaEdges: ignoreSafeAreaEdges))
    }

}


// MARK: - Modifier

internal struct CompositionModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    let layers: [SnapStyle.CompositionKey.Layer]
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        content
            .modifier(CompositionBackgroundOverlayModifier(keyPath: layers.contains(.backgroundOverlay) ? keyPath : nil, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            .modifier(CompositionBackgroundModifier(keyPath: layers.contains(.background) ? keyPath : nil, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            .modifier(CompositionForegroundModifier(keyPath: layers.contains(.foreground) ? keyPath : nil))
    }

}

internal struct CompositionForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        let surfaceKey: SnapStyle.SurfaceKey.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .foreground, for: keyPath) } else { nil }
        content
            .style(foreground: surfaceKey)
    }

}

internal struct CompositionBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let surfaceKey: SnapStyle.SurfaceKey.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .background, for: keyPath) } else { nil }
        content
            .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}

internal struct CompositionBackgroundOverlayModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let surfaceKey: SnapStyle.SurfaceKey.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .backgroundOverlay, for: keyPath) } else { nil }
        content
            .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}
