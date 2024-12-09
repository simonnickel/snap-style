//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    public func styleOverride(
        fonts: [SnapStyle.FontKey : SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]? = nil,
        surfaces: [SnapStyle.SurfaceKey : SnapStyle.ValueBuilder<SnapStyle.SurfaceKey.Value>]? = nil
    ) -> some View {
        self.modifier(
            StyleOverrideModifier(
                fonts: fonts,
                surfaces: surfaces
            )
        )
    }
    
}


// MARK: - Modifier

private struct StyleOverrideModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let fonts: [SnapStyle.FontKey : SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]?
    let surfaces: [SnapStyle.SurfaceKey : SnapStyle.ValueBuilder<SnapStyle.SurfaceKey.Value>]?

    func body(content: Content) -> some View {
        
        content
            .environment(\.style, style.replaced(fonts: fonts, surfaces: surfaces))
        
    }
    
}


// MARK: - SnapStyle: replaced

extension SnapStyle {
    
    internal func replaced(
        fonts: [FontKey : ValueBuilder<FontKey.Value>]? = nil,
        surfaces: [SurfaceKey : ValueBuilder<SurfaceKey.Value>]? = nil
    ) -> Self {
        var style = self

        if let fonts {
            style.apply(fonts, at: \.fonts)
        }

        if let surfaces {
            style.apply(surfaces, at: \.surfaces)
        }
        
        return style
    }
    
}
