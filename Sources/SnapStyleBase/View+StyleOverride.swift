//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    public func styleOverride(
        numbers: [SnapStyle.NumberKey.ValueBuilderKeyPath: SnapStyle.NumberKey.ValueBuilder]? = nil,
        fonts: [SnapStyle.FontKey.ValueBuilderKeyPath: SnapStyle.FontKey.ValueBuilder]? = nil,
        colors: [SnapStyle.ColorKey.ValueBuilderKeyPath: SnapStyle.ColorKey.ValueBuilder]? = nil,
        surfaces: [SnapStyle.SurfaceKey.ValueBuilderKeyPath: SnapStyle.SurfaceKey.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            StyleOverrideModifier(
                numbers: numbers,
                fonts: fonts,
                colors: colors,
                surfaces: surfaces
            )
        )
    }
    
}


// MARK: - Modifier

private struct StyleOverrideModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let numbers: [SnapStyle.NumberKey.ValueBuilderKeyPath: SnapStyle.NumberKey.ValueBuilder]?
    let fonts: [SnapStyle.FontKey.ValueBuilderKeyPath: SnapStyle.FontKey.ValueBuilder]?
    let colors: [SnapStyle.ColorKey.ValueBuilderKeyPath: SnapStyle.ColorKey.ValueBuilder]?
    let surfaces: [SnapStyle.SurfaceKey.ValueBuilderKeyPath: SnapStyle.SurfaceKey.ValueBuilder]?

    func body(content: Content) -> some View {
        
        content
            .environment(\.style, style.replaced(
                numbers: numbers,
                fonts: fonts,
                colors: colors,
                surfaces: surfaces
            ))
        
    }
    
}


// MARK: - SnapStyle: replaced

extension SnapStyle {
    
    internal func replaced(
        numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]? = nil,
        fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]? = nil,
        colors: [ColorKey.ValueBuilderKeyPath: ColorKey.ValueBuilder]? = nil,
        surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]? = nil
    ) -> Self {
        var style = self
        
        if let numbers {
            style = style.appended(numbers: numbers)
        }
        
        if let fonts {
            style = style.appended(fonts: fonts)
        }

        if let colors {
            style = style.appended(colors: colors)
        }
        
        if let surfaces {
            style = style.appended(surfaces: surfaces)
        }
        
        return style
    }
    
}
