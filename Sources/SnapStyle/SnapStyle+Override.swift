//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    func replaced(
        fonts: [FontKey : ValuesForContext<FontKey.Value>]? = nil
    ) -> Self {
        var style = self
        
        for (font, values) in fonts ?? [:] {
            style.fonts[font] = values
        }
        
        return style
    }
    
}

struct StyleOverride: ViewModifier {
    
    @Environment(\.style) private var style
    
    let fonts: [SnapStyle.FontKey : SnapStyle.ValuesForContext<SnapStyle.FontKey.Value>]?

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.replaced(fonts: fonts))
    }
    
}

extension View {
    
    public func styleOverride(
        fonts: [SnapStyle.FontKey : SnapStyle.ValuesForContext<SnapStyle.FontKey.Value>]? = nil
    ) -> some View {
        self.modifier(StyleOverride(fonts: fonts))
    }
    
}
