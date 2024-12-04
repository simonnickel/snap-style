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
        if let foreground = style.shapeStyle(layer: .foreground, for: key, in: styleComponent, hierarchy: hierarchy) {
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
        if let background = style.shapeStyle(layer: .background, for: key, in: styleComponent, hierarchy: hierarchy) {
            content
                .background(background)
        } else {
            content
        }
    }

}


// MARK: - SnapStyle Getter

extension SnapStyle {

    internal func shapeStyle(layer: SnapStyle.SurfaceKey.Layer, for key: SurfaceKey, in component: SnapStyle.Component, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> AnyShapeStyle? {

        guard let valueBuilder = surfaces[key] else {
            return surfaces[.fallback]?(component, hierarchy).wrappedValue.shapeStyle(for: layer) ?? SurfaceValues.values(for: SurfaceKey.fallback)(component, hierarchy).wrappedValue.shapeStyle(for: layer)
        }

        let value = valueBuilder(component, hierarchy)

        return switch value {
            case .reference(let key): shapeStyle(layer: layer, for: key, in: component, hierarchy: hierarchy)
            default: value.wrappedValue.shapeStyle(for: layer)
        }
    }
    
}
