//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    internal func replaced(
        fonts: [FontKey : ValueBuilder<FontKey.Value>]? = nil
    ) -> Self {
        var style = self
        
        for (font, values) in fonts ?? [:] {
            style.fonts[font] = values
        }
        
        return style
    }
    
}

internal struct StyleOverride: ViewModifier {
    
    @Environment(\.style) private var style
    
    let fonts: [SnapStyle.FontKey : SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]?

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.replaced(fonts: fonts))
    }
    
}

extension View {
    
    public func styleOverride(
        fonts: [SnapStyle.FontKey : SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]? = nil
    ) -> some View {
        self.modifier(StyleOverride(fonts: fonts))
    }
    
}
