//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    // TODO: .if modifier, insert array
    @ViewBuilder
    public func style(
        composition keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath,
        layer: SnapStyle.CompositionKey.Layer = .any,
        scope: SnapStyle.ComponentDefinition.ContainerScope = .component
    ) -> some View {
        self.modifier(CompositionModifier(keyPath: keyPath, layer: layer, scope: scope))
    }

}


// MARK: - Modifier

internal struct CompositionModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    let layer: SnapStyle.CompositionKey.Layer
    let scope: SnapStyle.ComponentDefinition.ContainerScope

    func body(content: Content) -> some View {
        if scope == .listRow {
            content.style(listRowBackground: keyPath)
        } else {
            switch layer {
                case .background:
                    content.modifier(CompositionBackgroundModifier(keyPath: keyPath))
                case .backgroundOverlay:
                    content.modifier(CompositionBackgroundOverlayModifier(keyPath: keyPath))
                case .foreground:
                    content.modifier(CompositionForegroundModifier(keyPath: keyPath))
                case .any:
                    content
                        .modifier(CompositionBackgroundOverlayModifier(keyPath: keyPath))
                        .modifier(CompositionBackgroundModifier(keyPath: keyPath))
                        .modifier(CompositionForegroundModifier(keyPath: keyPath))
            }
        }
    }

}

internal struct CompositionForegroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let foreground = style.composition(layer: .foreground, for: keyPath),
            let surface = style.surface(for: foreground)
        {
            content
                .foregroundStyle(surface)
        } else {
            content
        }
    }

}

internal struct CompositionBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        // Background has to be applied if a composition is available. Even if no value is present, to allow animation of appearing value.
        if let composition = style.composition(for: keyPath) {
            let surface = style.surface(layer: .background, composition: composition)
            content
                .background(surface ?? AnyShapeStyle(.clear), ignoresSafeAreaEdges: composition.ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}

internal struct CompositionBackgroundOverlayModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        // Background has to be applied if a composition is available. Even if no value is present, to allow animation of appearing value.
        if let composition = style.composition(for: keyPath) {
            let surface = style.surface(layer: .backgroundOverlay, composition: composition)
            content
                .background(surface ?? AnyShapeStyle(.clear), ignoresSafeAreaEdges: composition.ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}
