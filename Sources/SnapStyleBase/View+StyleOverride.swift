//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    public func styleOverride(
        numbers: [SnapStyle.NumberKey.ValueKeyPath: SnapStyle.ValueBuilder<SnapStyle.NumberKey.Value>]? = nil,
        fonts: [SnapStyle.FontKey.ValueKeyPath: SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]? = nil,
        surfaces: [SnapStyle.SurfaceKey.ValueKeyPath: SnapStyle.ValueBuilder<SnapStyle.SurfaceKey.Value>]? = nil
    ) -> some View {
        self.modifier(
            StyleOverrideModifier(
                numbers: numbers,
                fonts: fonts,
                surfaces: surfaces
            )
        )
    }
    
}


// MARK: - Modifier

private struct StyleOverrideModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let numbers: [SnapStyle.NumberKey.ValueKeyPath: SnapStyle.ValueBuilder<SnapStyle.NumberKey.Value>]?
    let fonts: [SnapStyle.FontKey.ValueKeyPath: SnapStyle.ValueBuilder<SnapStyle.FontKey.Value>]?
    let surfaces: [SnapStyle.SurfaceKey.ValueKeyPath: SnapStyle.ValueBuilder<SnapStyle.SurfaceKey.Value>]?

    func body(content: Content) -> some View {
        
        content
            .environment(\.style, style.replaced(fonts: fonts, surfaces: surfaces))
        
    }
    
}


// MARK: - SnapStyle: replaced

extension SnapStyle {
    
    internal func replaced(
        numbers: [NumberKey.ValueKeyPath: ValueBuilder<NumberKey.Value>]? = nil,
        fonts: [FontKey.ValueKeyPath: ValueBuilder<FontKey.Value>]? = nil,
        surfaces: [SurfaceKey.ValueKeyPath: ValueBuilder<SurfaceKey.Value>]? = nil
    ) -> Self {
        var style = self
        
        if let numbers {
            style.append(numbers: numbers)
        }
        
        if let fonts {
            style.append(fonts: fonts)
        }

        if let surfaces {
            style.append(surfaces: surfaces)
        }
        
        return style
    }
    
}
