//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func style(surface key: SnapStyle.SurfaceKey, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self
            .modifier(ForegroundModifier(key: key, hierarchy: hierarchy))
            .modifier(BackgroundModifier(key: key, hierarchy: hierarchy))
    }

}


// MARK: - Modifier

internal struct ForegroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleComponent) private var styleComponent

    let key: SnapStyle.SurfaceKey
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        if let foreground = style.surface(layer: .foreground, for: key, in: styleComponent, hierarchy: hierarchy) {
            content
                .foregroundStyle(foreground)
        } else {
            content
        }
    }
    
}

internal struct BackgroundModifier: ViewModifier {

    @Environment(\.style) private var style
    @Environment(\.styleComponent) private var styleComponent

    let key: SnapStyle.SurfaceKey
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        if let background = style.surface(layer: .background, for: key, in: styleComponent, hierarchy: hierarchy) {
            content
                .background(background)
        } else {
            content
        }
    }

}


// MARK: - SnapStyle Getter

extension SnapStyle {

    internal func surface(layer: SnapStyle.SurfaceKey.Layer, for key: SurfaceKey, in component: SnapStyle.Component, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> AnyShapeStyle? {

        guard let valueBuilder = surfaces[key] else {
            return surfaces[.fallback]?(component, hierarchy)?.wrappedValue.surface(for: layer) ?? SurfaceValues.values(for: SurfaceKey.fallback)(component, hierarchy)?.wrappedValue.surface(for: layer)
        }

        let value = valueBuilder(component, hierarchy) ?? SurfaceValues.defaultValues[key]?(component, hierarchy)

        switch value {
            case .reference(let key): return surface(layer: layer, for: key, in: component, hierarchy: hierarchy)
            default: return value?.wrappedValue.surface(for: layer)
        }
    }
    
}
