//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(surface keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(ForegroundModifier(keyPath: keyPath))
            .modifier(BackgroundModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

internal struct ForegroundModifier: ViewModifier {

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

internal struct BackgroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if
            let background = style.surface(layer: .background, for: keyPath, in: styleContext),
            let color = style.color(for: background, in: styleContext)
        {
            content
                .background(color)
        } else {
            content
        }
    }

}


// MARK: - FromEnvironmentModifier

internal struct ComponentSurfaceFromEnvironmentModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let layer: SnapStyle.SurfaceKey.Layer

    func body(content: Content) -> some View {
        let keyPath = SnapStyle.SurfaceKey.keyPath(for: styleContext.component.type)
        if
            let value = style.surface(layer: layer, for: keyPath, in: styleContext),
            let color = style.color(for: value, in: styleContext)
        {
            switch layer {
                case .any:
                    content
                        .foregroundStyle(color)
                        .background(color)
                case .foreground:
                    content
                        .foregroundStyle(color)
                case .background:
                    content
                        .background(color)
            }
        } else {
            content
        }
    }

}
internal struct ElementSurfaceFromEnvironmentModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext

    let layer: SnapStyle.SurfaceKey.Layer

    func body(content: Content) -> some View {
        let keyPath = SnapStyle.SurfaceKey.keyPath(for: styleContext.element.type)
        if
            let value = style.surface(layer: layer, for: keyPath, in: styleContext),
            let color = style.color(for: value, in: styleContext)
        {
            switch layer {
                case .any:
                    content
                        .foregroundStyle(color)
                        .background(color)
                case .foreground:
                    content
                        .foregroundStyle(color)
                case .background:
                    content
                        .background(color)
            }
        } else {
            content
        }
    }

}
