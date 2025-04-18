//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(surface keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(SurfaceForegroundModifier(keyPath: keyPath))
            .modifier(SurfaceBackgroundOverlayModifier(keyPath: keyPath))
            .modifier(SurfaceBackgroundModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct SurfaceForegroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let foreground = style.surface(layer: .foreground, for: keyPath, in: styleContext),
            let color = style.color(for: foreground, in: styleContext)
        {
            content
                .foregroundStyle(color)
        } else {
            content
        }
    }

}

internal struct SurfaceBackgroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let surface = style.surface(for: keyPath, in: styleContext),
            let background = surface.surface(for: .background),
            let color = style.color(for: background, in: styleContext)
        {
            content
                .background(color, ignoresSafeAreaEdges: surface.ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}

internal struct SurfaceBackgroundOverlayModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let surface = style.surface(for: keyPath, in: styleContext),
            let background = surface.surface(for: .backgroundOverlay),
            let color = style.color(for: background, in: styleContext)
        {
            content
                .background(color, ignoresSafeAreaEdges: surface.ignoresSafeAreaEdges)
        } else {
            content
        }
    }

}
