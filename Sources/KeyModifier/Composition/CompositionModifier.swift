//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    /// Applies the given `Layer` of the `Composition`.
    ///
    /// Supports animated change.
    ///
    /// - Parameters:
    ///   - keyPath: The `Composition` to apply.
    ///   - layers: The `Layer`s that should be applied
    ///   - ignoreSafeAreaEdges: Controls the safe area behaviour of the background.
    public func style(
        composition keyPath: Style.Keys.CompositionKey.ValueBuilderKeyPath,
        layers: [Style.Keys.CompositionKey.Layer] = Style.Keys.CompositionKey.Layer.allCases,
        ignoreSafeAreaEdges: Edge.Set = []
    ) -> some View {
        modifier(CompositionModifier(keyPath: keyPath, layers: layers, ignoresSafeAreaEdges: ignoreSafeAreaEdges))
    }

}


// MARK: - Modifier

private struct CompositionModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Keys.CompositionKey.ValueBuilderKeyPath
    let layers: [Style.Keys.CompositionKey.Layer]
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        content
            .modifier(CompositionBackgroundOverlayModifier(keyPath: layers.contains(.backgroundOverlay) ? keyPath : nil, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            .modifier(CompositionBackgroundModifier(keyPath: layers.contains(.background) ? keyPath : nil, ignoresSafeAreaEdges: ignoresSafeAreaEdges))
            .modifier(CompositionForegroundModifier(keyPath: layers.contains(.foreground) ? keyPath : nil))
    }

}

private struct CompositionForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Keys.CompositionKey.ValueBuilderKeyPath?

    func body(content: Content) -> some View {
        let surfaceKey: Style.Keys.SurfaceKey.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .foreground, for: keyPath) } else { nil }
        content
            .style(foreground: surfaceKey)
    }

}

private struct CompositionBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Keys.CompositionKey.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let surfaceKey: Style.Keys.SurfaceKey.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .background, for: keyPath) } else { nil }
        content
            .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}

private struct CompositionBackgroundOverlayModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: Style.Keys.CompositionKey.ValueBuilderKeyPath?
    let ignoresSafeAreaEdges: Edge.Set

    func body(content: Content) -> some View {
        let surfaceKey: Style.Keys.SurfaceKey.ValueBuilderKeyPath? = if let keyPath { style.surfaceKey(layer: .backgroundOverlay, for: keyPath) } else { nil }
        content
            .style(background: surfaceKey, ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }

}


// MARK: - Preview

#Preview {

    @Previewable @State var isAccent: Bool = false

    VStack() {
        Text("Content")
    }
    .padding()
    .style(composition: isAccent ? \.accentContainer : \.contentContainer)
    .border(.yellow)

    Button {
        withAnimation {
            isAccent.toggle()
        }
    } label: {
        Text("Toggle Accent")
    }

}
