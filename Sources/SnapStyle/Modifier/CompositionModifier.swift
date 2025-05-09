//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(composition keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath) -> some View {
        self.style(composition: keyPath, layer: .any)
    }
    
    @ViewBuilder
    public func style(composition keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath, layer: SnapStyle.CompositionKey.Layer) -> some View {
        switch layer {
            case .background:
                self.modifier(CompositionBackgroundModifier(keyPath: keyPath))
            case .backgroundOverlay:
                self.modifier(CompositionBackgroundOverlayModifier(keyPath: keyPath))
            case .foreground:
                self.modifier(CompositionForegroundModifier(keyPath: keyPath))
            case .any:
                self
                    .modifier(CompositionForegroundModifier(keyPath: keyPath))
                    .modifier(CompositionBackgroundOverlayModifier(keyPath: keyPath))
                    .modifier(CompositionBackgroundModifier(keyPath: keyPath))
        }
    }

}


// MARK: - Modifier

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
                .listRowBackground(
                    Rectangle().fill(.clear)
                        .style(composition: keyPath)
                )
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
