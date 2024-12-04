//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

internal struct ColorModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleComponent) private var styleComponent

    let key: SnapStyle.ColorKey
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        let value = style.color(for: key, in: styleComponent, hierarchy: hierarchy)
        content
            .foregroundStyle(value)
    }
    
}

extension View {
    
    public func color(_ key: SnapStyle.ColorKey, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self.modifier(ColorModifier(key: key, hierarchy: hierarchy))
    }
    
}

extension SnapStyle {
    
    internal func color(for key: ColorKey, in component: SnapStyle.Component, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> Color {
        guard let valueBuilder = colors[key] else {
            return colors[.fallback]?(component, hierarchy).wrappedValue ?? ColorValues.values(for: ColorKey.fallback)(component, hierarchy).wrappedValue
        }

        let value = valueBuilder(component, hierarchy)

        return switch value {
            case .reference(let key): color(for: key, in: component, hierarchy: hierarchy)
            default: value.wrappedValue
        }
    }
    
}
