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

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if let foreground = style.surface(layer: .foreground, for: keyPath, in: .any) {
            content
                .foregroundStyle(foreground)
        } else {
            content
        }
    }

}

internal struct BackgroundModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.SurfaceKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        if let background = style.surface(layer: .background, for: keyPath, in: .any) {
            content
                .background(background)
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
        if
            let keyPath = SnapStyle.SurfaceKey.keyPath(for: styleContext.component.type),
            let value = style.surface(layer: layer, for: keyPath, in: styleContext)
        {
            switch layer {
                case .any:
                    content
                        .foregroundStyle(value)
                        .background(value)
                case .foreground:
                    content
                        .foregroundStyle(value)
                case .background:
                    content
                        .background(value)
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
        let value = style.surface(layer: layer, for: keyPath, in: styleContext)

        if let value {
            switch layer {
                case .any:
                    content
                        .foregroundStyle(value)
                        .background(value)
                case .foreground:
                    content
                        .foregroundStyle(value)
                case .background:
                    content
                        .background(value)
            }
        } else {
            content
        }
    }

}
