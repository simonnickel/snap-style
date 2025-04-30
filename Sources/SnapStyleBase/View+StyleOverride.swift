//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {
    
    public func styleOverride(
        numbers: [SnapStyle.NumberKey.ValueBuilderKeyPath: SnapStyle.NumberKey.ValueBuilder]? = nil,
        fonts: [SnapStyle.FontKey.ValueBuilderKeyPath: SnapStyle.FontKey.ValueBuilder]? = nil,
        surfaces: [SnapStyle.SurfaceKey.ValueBuilderKeyPath: SnapStyle.SurfaceKey.ValueBuilder]? = nil,
        compositions: [SnapStyle.CompositionKey.ValueBuilderKeyPath: SnapStyle.CompositionKey.ValueBuilder]? = nil,
        shapes: [SnapStyle.ShapeKey.ValueBuilderKeyPath: SnapStyle.ShapeKey.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            StyleOverrideModifier(
                numbers: numbers,
                fonts: fonts,
                surfaces: surfaces,
                compositions: compositions,
                shapes: shapes
            )
        )
    }
    
}


// MARK: - Modifier

private struct StyleOverrideModifier: ViewModifier {
    
    @Environment(\.styleDefinition) private var style
    
    let numbers: [SnapStyle.NumberKey.ValueBuilderKeyPath: SnapStyle.NumberKey.ValueBuilder]?
    let fonts: [SnapStyle.FontKey.ValueBuilderKeyPath: SnapStyle.FontKey.ValueBuilder]?
    let surfaces: [SnapStyle.SurfaceKey.ValueBuilderKeyPath: SnapStyle.SurfaceKey.ValueBuilder]?
    let compositions: [SnapStyle.CompositionKey.ValueBuilderKeyPath: SnapStyle.CompositionKey.ValueBuilder]?
    let shapes: [SnapStyle.ShapeKey.ValueBuilderKeyPath: SnapStyle.ShapeKey.ValueBuilder]?

    func body(content: Content) -> some View {
        
        // TODO: Update context with new definition
        content
            .environment(\.styleDefinition, style.replaced(
                numbers: numbers,
                fonts: fonts,
                surfaces: surfaces,
                compositions: compositions,
                shapes: shapes
            ))
        
    }
    
}


// MARK: - SnapStyle: replaced

extension SnapStyle {
    
    internal func replaced(
        numbers: [NumberKey.ValueBuilderKeyPath: NumberKey.ValueBuilder]? = nil,
        fonts: [FontKey.ValueBuilderKeyPath: FontKey.ValueBuilder]? = nil,
        surfaces: [SurfaceKey.ValueBuilderKeyPath: SurfaceKey.ValueBuilder]? = nil,
        compositions: [CompositionKey.ValueBuilderKeyPath: CompositionKey.ValueBuilder]? = nil,
        shapes: [ShapeKey.ValueBuilderKeyPath: ShapeKey.ValueBuilder]? = nil
    ) -> Self {
        var style = self
        
        if let numbers {
            style = style.appended(numbers: numbers)
        }
        
        if let fonts {
            style = style.appended(fonts: fonts)
        }

        if let surfaces {
            style = style.appended(surfaces: surfaces)
        }
        
        if let compositions {
            style = style.appended(compositions: compositions)
        }
        
        if let shapes {
            style = style.appended(shapes: shapes)
        }
        
        return style
    }
    
}
