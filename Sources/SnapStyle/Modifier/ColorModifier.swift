//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

internal struct ColorModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let key: SnapStyle.ColorKey
    
    func body(content: Content) -> some View {
        let value = style.color(for: key, in: styleContext)
        content
            .foregroundStyle(value)
    }
    
}

extension View {
    
    public func color(_ key: SnapStyle.ColorKey) -> some View {
        self.modifier(ColorModifier(key: key))
    }
    
}

extension SnapStyle {
    
    internal func color(for key: ColorKey, in context: Context) -> Color {
        guard let value = colors[key]?.value(in: context) else {
            return colors[.fallback]?.value(in: context).value ?? DefaultValues.values(for: ColorKey.fallback).value(in: context).value
        }
        
        return switch value {
            case .reference(let key): color(for: key, in: context)
            default: value.value
        }
    }
    
}
