//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SwiftUI

extension View {

    @ViewBuilder
    public func style(
        composition keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath,
        layers: [SnapStyle.CompositionKey.Layer] = SnapStyle.CompositionKey.Layer.allCases,
        ignoreSafeAreaEdges: Edge.Set = []
    ) -> some View {
        self.modifier(CompositionModifier(keyPath: keyPath, layers: layers, ignoresSafeAreaEdges: ignoreSafeAreaEdges))
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
            .if(layers.contains(.backgroundOverlay)) { content in
                content.modifier(CompositionBackgroundOverlayModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            }
            .if(layers.contains(.background)) { content in
                content.modifier(CompositionBackgroundModifier(keyPath: keyPath, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            }
            .if(layers.contains(.foreground)) { content in
                content.modifier(CompositionForegroundModifier(keyPath: keyPath))
            }
    }

}

internal struct CompositionForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if let surfaceKey = style.surfaceKey(layer: .foreground, for: keyPath) {
            content
                .style(foreground: surfaceKey)
        } else {
            content
        }
    }

}

internal struct CompositionBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        if let surfaceKey = style.surfaceKey(layer: .background, for: keyPath) {
            content
                .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}

internal struct CompositionBackgroundOverlayModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        if let surfaceKey = style.surfaceKey(layer: .backgroundOverlay, for: keyPath) {
            content
                .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}
