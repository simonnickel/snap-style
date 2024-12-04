//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle {
    
    internal func replaced(
        fonts: [FontKey : ValueBuilder<FontKey.Value>]? = nil,
        surfaces: [SurfaceKey : ValueBuilder<SurfaceKey.Value>]? = nil
    ) -> Self {
        var style = self
        
        for (key, valueBuilder) in fonts ?? [:] {
            style.fonts[key] = valueBuilder
        }

        for (key, valueBuilder) in surfaces ?? [:] {
            style.surfaces[key] = valueBuilder
        }
        
        return style
    }
    
}

internal struct StyleOverride: ViewModifier {
    
    @Environment(\.style) private var style
    
    let fonts: [SnapStyle.FontKey : SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]?
    let surfaces: [SnapStyle.SurfaceKey : SnapStyle.ValueBuilder<SnapStyle.SurfaceKey.Value>]?

    func body(content: Content) -> some View {
        content
            .environment(\.style, style.replaced(fonts: fonts, surfaces: surfaces))
    }
    
}

extension View {
    
    public func styleOverride(
        fonts: [SnapStyle.FontKey : SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]? = nil,
        surfaces: [SnapStyle.SurfaceKey : SnapStyle.ValueBuilder<SnapStyle.SurfaceKey.Value>]? = nil
    ) -> some View {
        self.modifier(StyleOverride(fonts: fonts, surfaces: surfaces))
    }
    
}
