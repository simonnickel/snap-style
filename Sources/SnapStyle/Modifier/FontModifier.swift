//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

internal struct FontModifier: ViewModifier {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let key: SnapStyle.FontKey
    
    func body(content: Content) -> some View {
        let value = style.font(for: key, in: styleContext)
        content
            .font(value)
    }
    
}

extension View {
    
    public func font(_ key: SnapStyle.FontKey) -> some View {
        self.modifier(FontModifier(key: key))
    }
    
}

extension SnapStyle {
    
    internal func font(for key: FontKey, in context: Context) -> Font {
        guard let value = fonts[key]?.value(in: context) else {
            return fonts[.fallback]?.value(in: context).wrappedValue ?? FontValues.values(for: FontKey.fallback).value(in: context).wrappedValue
        }
        
        return switch value {
            case .reference(let key): font(for: key, in: context)
            default: value.wrappedValue
        }
    }
    
}
