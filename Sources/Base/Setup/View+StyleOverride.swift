//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension View {

    public func styleOverride(
        numbers: [Style.Keys.NumberKey.ValueBuilderKeyPath: Style.Keys.NumberKey.ValueBuilder]? = nil,
        fonts: [Style.Keys.FontKey.ValueBuilderKeyPath: Style.Keys.FontKey.ValueBuilder]? = nil,
        icons: [Style.Keys.IconKey.ValueBuilderKeyPath: Style.Keys.IconKey.ValueBuilder]? = nil,
        surfaces: [Style.Keys.SurfaceKey.ValueBuilderKeyPath: Style.Keys.SurfaceKey.ValueBuilder]? = nil,
        compositions: [Style.Keys.CompositionKey.ValueBuilderKeyPath: Style.Keys.CompositionKey.ValueBuilder]? = nil,
        accents: [Style.Keys.AccentKey.ValueBuilderKeyPath: Style.Keys.AccentKey.ValueBuilder]? = nil,
        shapes: [Style.Keys.ShapeKey.ValueBuilderKeyPath: Style.Keys.ShapeKey.ValueBuilder]? = nil
    ) -> some View {
        self.modifier(
            Style.OverrideModifier(
                numbers: numbers,
                fonts: fonts,
                icons: icons,
                surfaces: surfaces,
                compositions: compositions,
                accents: accents,
                shapes: shapes
            )
        )
    }

}


// MARK: - Modifier

extension Style {
    
    struct OverrideModifier: ViewModifier {
        
        @Environment(\.style) private var style
        
        let numbers: [Keys.NumberKey.ValueBuilderKeyPath: Keys.NumberKey.ValueBuilder]?
        let fonts: [Keys.FontKey.ValueBuilderKeyPath: Keys.FontKey.ValueBuilder]?
        let icons: [Keys.IconKey.ValueBuilderKeyPath: Keys.IconKey.ValueBuilder]?
        let surfaces: [Keys.SurfaceKey.ValueBuilderKeyPath: Keys.SurfaceKey.ValueBuilder]?
        let compositions: [Keys.CompositionKey.ValueBuilderKeyPath: Keys.CompositionKey.ValueBuilder]?
        let accents: [Keys.AccentKey.ValueBuilderKeyPath: Keys.AccentKey.ValueBuilder]?
        let shapes: [Keys.ShapeKey.ValueBuilderKeyPath: Keys.ShapeKey.ValueBuilder]?
        
        func body(content: Content) -> some View {
            
            let definition = style.definition.replaced(
                numbers: numbers,
                fonts: fonts,
                icons: icons,
                surfaces: surfaces,
                compositions: compositions,
                accents: accents,
                shapes: shapes
            )
            
            content
                .style(update: definition)
            
        }
        
    }
    
}


// MARK: - SnapStyle: replaced

extension Style {

    internal func replaced(
        numbers: [Keys.NumberKey.ValueBuilderKeyPath: Keys.NumberKey.ValueBuilder]? = nil,
        fonts: [Keys.FontKey.ValueBuilderKeyPath: Keys.FontKey.ValueBuilder]? = nil,
        icons: [Keys.IconKey.ValueBuilderKeyPath: Keys.IconKey.ValueBuilder]? = nil,
        surfaces: [Keys.SurfaceKey.ValueBuilderKeyPath: Keys.SurfaceKey.ValueBuilder]? = nil,
        compositions: [Keys.CompositionKey.ValueBuilderKeyPath: Keys.CompositionKey.ValueBuilder]? = nil,
        accents: [Keys.AccentKey.ValueBuilderKeyPath: Keys.AccentKey.ValueBuilder]? = nil,
        shapes: [Keys.ShapeKey.ValueBuilderKeyPath: Keys.ShapeKey.ValueBuilder]? = nil
    ) -> Self {
        var style = self

        if let numbers {
            style = style.appended(numbers: numbers)
        }

        if let fonts {
            style = style.appended(fonts: fonts)
        }

        if let icons {
            style = style.appended(icons: icons)
        }

        if let surfaces {
            style = style.appended(surfaces: surfaces)
        }

        if let compositions {
            style = style.appended(compositions: compositions)
        }

        if let accents {
            style = style.appended(accents: accents)
        }

        if let shapes {
            style = style.appended(shapes: shapes)
        }

        return style
    }

}
