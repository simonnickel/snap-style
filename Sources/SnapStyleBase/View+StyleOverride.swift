//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    public func styleOverride(
        numbers: [SnapStyle.NumberKey.ValueKeyPath: SnapStyle.NumberKey.ValueBuilder]? = nil,
        fonts: [SnapStyle.FontKey.ValueKeyPath: SnapStyle.FontKey.ValueBuilder]? = nil,
        surfaces: [SnapStyle.SurfaceKey.ValueKeyPath: SnapStyle.SurfaceKey.ValueBuilder]? = nil
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
    
    let numbers: [SnapStyle.NumberKey.ValueKeyPath: SnapStyle.NumberKey.ValueBuilder]?
    let fonts: [SnapStyle.FontKey.ValueKeyPath: SnapStyle.FontKey.ValueBuilder]?
    let surfaces: [SnapStyle.SurfaceKey.ValueKeyPath: SnapStyle.SurfaceKey.ValueBuilder]?

    func body(content: Content) -> some View {
        
        content
            .environment(\.style, style.replaced(fonts: fonts, surfaces: surfaces))
        
    }
    
}


// MARK: - SnapStyle: replaced

extension SnapStyle {
    
    internal func replaced(
        numbers: [NumberKey.ValueKeyPath: NumberKey.ValueBuilder]? = nil,
        fonts: [FontKey.ValueKeyPath: FontKey.ValueBuilder]? = nil,
        surfaces: [SurfaceKey.ValueKeyPath: SurfaceKey.ValueBuilder]? = nil
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
