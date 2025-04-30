//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(composition keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(CompositionForegroundModifier(keyPath: keyPath))
            .modifier(CompositionBackgroundOverlayModifier(keyPath: keyPath))
            .modifier(CompositionBackgroundModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct CompositionForegroundModifier: ViewModifier {

    @Environment(\.styleDefinition) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let foreground = style.composition(layer: .foreground, for: keyPath, in: styleContext),
            let surface = style.surface(for: foreground, in: styleContext)
        {
            content
                .foregroundStyle(surface)
        } else {
            content
        }
    }

}

internal struct CompositionBackgroundModifier: ViewModifier {

    @Environment(\.styleDefinition) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        // Background has to be applied if a composition is available. Even if no value is present, to allow animation of appearing value.
        if let composition = style.composition(for: keyPath, in: styleContext) {
            let surface = style.surface(layer: .background, composition: composition, in: styleContext)
            content
                .background(surface ?? AnyShapeStyle(.clear), ignoresSafeAreaEdges: composition.ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}

internal struct CompositionBackgroundOverlayModifier: ViewModifier {

    @Environment(\.styleDefinition) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        // Background has to be applied if a composition is available. Even if no value is present, to allow animation of appearing value.
        if let composition = style.composition(for: keyPath, in: styleContext) {
            let surface = style.surface(layer: .backgroundOverlay, composition: composition, in: styleContext)
            content
                .background(surface ?? AnyShapeStyle(.clear), ignoresSafeAreaEdges: composition.ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}
