//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func style(font key: SnapStyle.FontKey, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> some View {
        self.modifier(FontModifier(key: key, hierarchy: hierarchy))
    }

}


// MARK: - Modifier

internal struct FontModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleComponent) private var styleComponent

    let key: SnapStyle.FontKey
    let hierarchy: SnapStyle.Item.Hierarchy

    func body(content: Content) -> some View {
        let value = style.font(for: key, in: styleComponent, hierarchy: hierarchy)
        content
            .font(value)
    }
    
}


// MARK: - SnapStyle Getter

extension SnapStyle {
    
    internal func font(for key: FontKey, in component: SnapStyle.Component, hierarchy: SnapStyle.Item.Hierarchy = .primary) -> Font? {
        
        guard let valueBuilder = fonts[key] else {
            return fonts[.fallback]?(component, hierarchy)?.wrappedValue ?? FontValues.values(for: FontKey.fallback)(component, hierarchy)?.wrappedValue
        }

        let value = valueBuilder(component, hierarchy) ?? FontValues.defaultValues[key]?(component, hierarchy)

        return switch value {
            case .reference(let key): font(for: key, in: component, hierarchy: hierarchy)
            default: value?.wrappedValue
        }
    }
    
}
